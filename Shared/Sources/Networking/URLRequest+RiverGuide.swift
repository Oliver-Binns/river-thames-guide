//
//  URLRequestPool.swift
//  TFLStatus
//
//  Created by Oliver Binns on 24/06/2020.
//

import Foundation

extension URLRequest {
    private static var baseURL: String { "https://www.riverthamesguide.net/eaparse/" }

    public static func statusForLocation(_ location: Location) -> URLRequest {
        .init(endpoint: "\(location.rawValue).php")
    }

    init(endpoint: String...) {
        guard let url = URL(string: Self.baseURL + endpoint.joined(separator: "/")) else {
            preconditionFailure("Expected a valid URL")
        }
        self.init(url: url)
    }
}
