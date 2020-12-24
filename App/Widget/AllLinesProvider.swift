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

struct AllLinesProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), conditions: .placeholder)
    }

    public func getSnapshot(in context: Context,
                            completion: @escaping (SimpleEntry) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: .marsh) { updates in
            completion(placeholder(in: context))
        }
    }

    public func getTimeline(in context: Context,
                            completion: @escaping (Timeline<Entry>) -> ()) {
        StatusService.getStatus(client: NetworkClient(), for: .marsh) { updates in
            let entry = SimpleEntry(date: Date(), conditions: updates)
            // Refresh the data every two minutes:
            let expiryDate = Calendar.current.date(byAdding: .minute, value: 2, to: Date()) ?? Date()
            let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let conditions: LocationConditions
}
struct AllLinesWidget: Widget {
    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: "All Lines",
                            provider: AllLinesProvider()) { entry in
            StaticContentView(updates: entry.conditions)
        }
        .configurationDisplayName("Tube Status")
        .description("See the status board for all London Underground lines")
        .supportedFamilies([.systemLarge])
    }
}
