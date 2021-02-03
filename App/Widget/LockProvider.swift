//
//  Homescreen.swift
//  Homescreen
//
//  Created by Oliver Binns on 24/06/2020.
//
import Combine
import Shared
import WidgetKit
import SwiftUI

final class LockProvider: IntentTimelineProvider {
    typealias Intent = LockSelectionIntent

    private var cancellables: [AnyCancellable] = []

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), result: .success([.init(name: "Test",
                                                 condition: "Test",
                                                 lastUpdated: .init())]))
    }

    public func getSnapshot(for configuration: LockSelectionIntent,
                            in context: Context,
                            completion: @escaping (SimpleEntry) -> ()) {
        /*StatusService
            .getStatuses(for: .marsh)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    completion()
                  })*/

        /* { updates in
            completion(self.placeholder(in: context))
        }*/
    }

    public func getTimeline(for configuration: LockSelectionIntent,
                            in context: Context,
                            completion: @escaping (Timeline<Entry>) -> ()) {
        StatusService
            .getStatuses(for: configuration.location)
            .sink(receiveCompletion: {
                if case .failure(let error) = $0 {
                    completion(self.wrapResult(result: .failure(error)))
                }
            }, receiveValue: {
                completion(self.wrapResult(result: .success($0)))
            })
            .store(in: &cancellables)
    }

    private func wrapResult(result: Result<[Stretch], Error>) -> Timeline<SimpleEntry> {
        let expiryDate = Calendar.current.date(byAdding: .second, value: 30, to: Date()) ?? Date()
        let entry = SimpleEntry(date: Date(), result: result)
        return Timeline(entries: [entry], policy: .after(expiryDate))
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let result: Result<[Stretch], Error>
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
