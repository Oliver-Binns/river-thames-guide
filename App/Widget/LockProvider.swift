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

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), result: .success(.init(name: "Test",
                                                 condition: "Test",
                                                 lastUpdated: .init())))
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
        StatusService.getStatus(client: NetworkClient(), for: configuration.location) { result in
            DispatchQueue.main.async {
                let expiryDate = Calendar.current.date(byAdding: .second, value: 30, to: Date()) ?? Date()
                let entry = SimpleEntry(date: Date(), result: result)
                let timeline = Timeline(entries: [entry], policy: .after(expiryDate))
                completion(timeline)
            }
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let result: Result<Stretch, Error>
}
struct AllLinesWidget: Widget {
    public var body: some WidgetConfiguration {
        IntentConfiguration(kind: "Lock",
                            intent: LockSelectionIntent.self,
                            provider: LockProvider()) { entry in
            GeometryReader { metrics in
                ContentView(result: .init(get: { entry.result },
                                          set: { _ in }))
                    .frame(width: metrics.size.width, height: metrics.size.height)
            }
        }
        .configurationDisplayName("River Widget")
        .description("See the status board for all London Underground lines")
        .supportedFamilies([.systemMedium])
    }
}
extension LockSelectionIntent {
    var location: Lock {
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
