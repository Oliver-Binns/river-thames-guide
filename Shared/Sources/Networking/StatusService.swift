//
//  StatusService.swift
//  TFLStatus
//
//  Created by Oliver Binns on 24/06/2020.
//
import Foundation
import Combine

public struct StatusService {
    private static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd MMM"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }

    public static func getStatuses(for location: Lock) -> AnyPublisher<[Stretch], Error> {
        
        Publishers.MergeMany(
            [location.previous, location, location.next]
                .compactMap { $0 }
                .map { getStatus(for: $0) }
        )
        .collect()
        .map { $0.sorted() }
        .eraseToAnyPublisher()
    }

    public static func getStatus(for location: Lock) -> AnyPublisher<Stretch, Error> {
        runStatusRequest(.statusForLocation(location))
    }

    private static func runStatusRequest(_ request: URLRequest) -> AnyPublisher<Stretch, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Stretch.self, decoder: jsonDecoder)
            .eraseToAnyPublisher()
    }
}
