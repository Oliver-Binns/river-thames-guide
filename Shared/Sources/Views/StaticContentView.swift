//
//  FixedHeightContentView.swift
//  Shared
//
//  Created by Laptop 3 on 11/07/2020.
//
import SwiftUI

public struct StaticContentView: View {
    private let updates: LocationConditions

    public init(updates: LocationConditions) {
        self.updates = updates
    }

    public var body: some View {
        GeometryReader { metrics in
            ContentView(updates: updates)
                .frame(width: metrics.size.width,
                       height: metrics.size.height)
        }
    }
}
struct FixedHeightContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(updates: .placeholder)
    }
}
