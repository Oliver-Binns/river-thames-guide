//
//  WebViewImageViewModel.swift
//  Shared
//
//  Created by Laptop 3 on 23/01/2021.
//
import WebKit
import Combine
import UIKit

final class ImageWebView: NSObject, ObservableObject {
    private let webView = WKWebView()
    @Published var image: UIImage? = nil

    convenience init?(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        self.init()

        let drawSize = UIScreen.screens.first?.bounds.size ?? CGSize(width: 300, height: 100)
        webView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: drawSize)

        webView.navigationDelegate = self
        webView.loadHTMLString(string, baseURL: nil)
    }
}
extension ImageWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let configuration = WKSnapshotConfiguration()
        self.webView.takeSnapshot(with: configuration) { image, error in
            self.image = image
        }
    }
}
