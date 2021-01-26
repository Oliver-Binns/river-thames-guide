//
//  StatusService.swift
//  TFLStatus
//
//  Created by Oliver Binns on 24/06/2020.
//
import Foundation
import SwiftSoup

public struct StatusService {
    enum StatusServiceError: Error {
        case invalidHTMLData
    }

    public static func getStatus(client: NetworkClient,
                                 for location: Location,
                                 completion: ((Data) -> Void)? = nil) {
        runStatusRequest(.statusForLocation(location), on: client, completion: completion)
    }

    private static func runStatusRequest(_ request: URLRequest,
                                         on client: NetworkClient,
                                         completion: ((Data) -> Void)? = nil) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                completion?(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
