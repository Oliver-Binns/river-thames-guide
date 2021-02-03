//
//  ContentView.swift
//  Shared
//
//  Created by Oliver Binns on 25/06/2020.
//
import SwiftUI

public struct StretchView: View {
    let stretch: Stretch

    private var formatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMM"
        return dateFormatter
    }

    public init(stretch: Stretch) {
        self.stretch = stretch
    }

    public var body: some View {
        VStack {
            Text(stretch.name)
                .font(.subheadline)
            HStack {
                Text(stretch.condition)
                    .foregroundColor(stretch.colour)
                    .font(.caption2)
                Text("Last Updated: \(formatter.string(from: stretch.lastUpdated))")
                    .font(.caption2)
            }
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
