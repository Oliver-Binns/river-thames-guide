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

final class LockProvider: IntentTimelineProvider {
    typealias Intent = LockSelectionIntent
    var imageWebView: ImageWebView?

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(systemName: "circle")!)
    }

    public func getSnapshot(for configuration: LockSelectionIntent,
                            in context: Context,
                            completion: @escaping (SimpleEntry) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: .marsh) { updates in
            completion(self.placeholder(in: context))
        }
    }

    public func getTimeline(for configuration: LockSelectionIntent,
                            in context: Context,
                            completion: @escaping (Timeline<Entry>) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: configuration.location) { htmlData in
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
        IntentConfiguration(kind: "Lock",
                            intent: LockSelectionIntent.self,
                            provider: LockProvider()) { entry in
            GeometryReader { metrics in
                Image(uiImage: entry.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: metrics.size.width, height: metrics.size.height)
            }
        }
        .configurationDisplayName("River Widget")
        .description("See the status board for all London Underground lines")
        .supportedFamilies([.systemMedium])
    }
}
extension LockSelectionIntent {
    var location: Location {
        switch self.lock {
        case .buscot:
            return .buscot
        case .marsh:
            return .marsh
        case .rushey:
            return .rushey
        default:
            return .shiplake
        }
    }
}
