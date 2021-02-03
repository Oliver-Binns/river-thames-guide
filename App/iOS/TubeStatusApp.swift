//
//  TubeStatusApp.swift
//  TubeStatus
//
//  Created by Oliver Binns on 24/06/2020.
//
import Combine
import Shared
import SwiftUI

@main
struct TubeStatusApp: App {
    @State private var cancellables: [AnyCancellable] = []
    @State private var result: Result<[Stretch], Error>?

    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView(result: $result)
            }.onAppear(perform: onLoad)
        }
    }

    private func onLoad() {
        StatusService
            .getStatuses(for: .marsh)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    result = .failure(error)
                }
            }, receiveValue: {
                result = .success($0)
            })
            .store(in: &cancellables)
    }
}
