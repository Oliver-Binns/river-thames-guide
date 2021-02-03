//
//  StatusService.swift
//  TFLStatus
//
//  Created by Oliver Binns on 24/06/2020.
//
import Foundation

public struct StatusService {
    enum StatusServiceError: Error {
        case invalidJSONData
    }

    public static func getStatuses(client: NetworkClient,
                                   for location: Lock,
                                   completion: @escaping (Result<[Stretch], Error>) -> Void) {
        [location.previous, location, location.next]
            .compactMap { $0 }
    }

    public static func getStatus(client: NetworkClient,
                                 for location: Lock,
                                 completion: @escaping (Result<Stretch, Error>) -> Void) {
        runStatusRequest(.statusForLocation(location), on: client, completion: completion)
    }

    private static func runStatusRequest(_ request: URLRequest,
                                         on client: NetworkClient,
                                         completion: @escaping (Result<Stretch, Error>) -> Void) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm dd MMM"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                do {
                    let stretch = try decoder.decode(Stretch.self, from: data)
                    completion(.success(stretch))
                } catch {
                    completion(.failure(StatusServiceError.invalidJSONData))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
