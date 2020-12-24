//
//  ContentView.swift
//  Shared
//
//  Created by Oliver Binns on 25/06/2020.
//

import SwiftUI

struct ContentView: View {
    let updates: LocationConditions

    public init(updates: LocationConditions) {
        self.updates = updates
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(updates.title)
                .font(.largeTitle)
            ForEach(updates.conditions) { update in
                VStack {
                    Text("Test")
                    //LineStatusView(update: update)
                        .padding(0)
                    /*if displayReason,
                       let reason = update.statuses.first?.reason {
                        Text(reason.trimmingCharacters(in: .whitespacesAndNewlines))
                            .font(.body)
                            .lineLimit(nil)
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                    }*/
                }
                .accessibility(addTraits: [.isStaticText])
                .accessibility(removeTraits: [.isImage])
                .accessibilityElement(children: .combine)
            }
            Text("Feed Last Updated by EA: \(updates.feedLastUpdated?.description ?? "N/A")")
                .foregroundColor(.secondary)
            Text("Widget Last Updated: \(updates.feedLastUpdated?.description ?? "N/A")")
                .foregroundColor(.secondary)
        }.padding()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(updates: .placeholder)
    }
}
