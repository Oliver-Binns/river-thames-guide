//
//  ContentView.swift
//  Shared
//
//  Created by Oliver Binns on 25/06/2020.
//
import SwiftUI

public struct StretchView: View {
    let stretch: Stretch

    public init(stretch: Stretch) {
        self.stretch = stretch
    }

    public var body: some View {
        VStack {
            Text(stretch.name)
            Text(stretch.condition)
                .foregroundColor(stretch.colour)
        }
    }
}
struct StretchView_Previews: PreviewProvider {
    static var previews: some View {
        StretchView(stretch: .init(name: "Test",
                                   condition: "Test 2",
                                   lastUpdated: .init()))
    }
}
