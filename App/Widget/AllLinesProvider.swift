//
//  Homescreen.swift
//  Homescreen
//
//  Created by Oliver Binns on 24/06/2020.
//

import Foundation
import Shared
import WidgetKit
import SwiftUI
import WebKit
import UIKit

final class AllLinesProvider: TimelineProvider {
    var imageWebView: ImageWebView?

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(systemName: "circle")!)
    }

    public func getSnapshot(in context: Context,
                            completion: @escaping (SimpleEntry) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: .marsh) { updates in
            completion(self.placeholder(in: context))
        }
    }

    public func getTimeline(in context: Context,
                            completion: @escaping (Timeline<Entry>) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: .marsh) { htmlData in
            DispatchQueue.main.async {
                self.imageWebView = ImageWebView(data: htmlData) { image in
                    let entry = SimpleEntry(date: Date(), image: image)
                    // Refresh the data every two minutes:
                    let expiryDate = Calendar.current.date(byAdding: .second, value: 30, to: Date()) ?? Date()
                    let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
                    completion(timeline)
                }
            }
        }
    }
}
final class ImageWebView: NSObject {
    private let webView = WKWebView()
    private var onLoad: ((UIImage) -> Void)? = nil

    convenience init?(data: Data, onLoad: @escaping (UIImage) -> Void) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init()

        let drawSize = CGSize(width: 300, height: 100)
        webView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: drawSize)

        self.onLoad = onLoad
        webView.navigationDelegate = self
        webView.loadHTMLString(string, baseURL: nil)
    }
}
extension ImageWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.takeSnapshot(with: .init()) { image, error in
            self.onLoad?(image!)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}
struct AllLinesWidget: Widget {
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: "All Lines",
                            provider: AllLinesProvider()) { entry in
            Image(uiImage: entry.image)
            //ContentView(htmlData: entry.htmlData)
        }
        .configurationDisplayName("River Widget")
        .description("See the status board for all London Underground lines")
        .supportedFamilies([.systemMedium])
    }
}
