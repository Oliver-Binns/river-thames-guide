//
//  ContentView.swift
//  Shared
//
//  Created by Oliver Binns on 25/06/2020.
//
import SwiftUI
import WebKit

public struct ContentView: View {
    private let htmlData: Data
    @ObservedObject var model: ImageWebView

    public init(htmlData: Data) {
        self.htmlData = htmlData
        self.model = ImageWebView(data: htmlData)!
    }

    public var body: some View {
        GeometryReader { metrics in
            Image(uiImage: model.image ?? UIImage(systemName: "nosign")!)
                .frame(width: metrics.size.width,
                       height: metrics.size.height)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(htmlData: .init())
    }
}
