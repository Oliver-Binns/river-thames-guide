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
                                 completion: ((LocationConditions) -> Void)? = nil) {
        runStatusRequest(.statusForLocation(location), on: client, completion: completion)
    }

    private static func runStatusRequest(_ request: URLRequest,
                                         on client: NetworkClient,
                                         completion: ((LocationConditions) -> Void)? = nil) {
        client.executeRequest(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    guard let rawHTML = String(data: data, encoding: .utf8),
                          let bodyContent = try SwiftSoup.parse(rawHTML).body() else {
                        throw StatusServiceError.invalidHTMLData
                    }

                    let title = try bodyContent.getElementsByTag("h1").text()
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    let table = try bodyContent.getElementsByTag("table")
                        .first()?
                        .getElementsByTag("tr")

                    let conditions = (table?.array() ?? [Element].init()).map { row -> String in
                        print(try? row.getElementsByTag("td").compactMap { try? $0.text() })
                        return "Test"
                    }
                
                    completion?(.init(title: title, conditions: [], feedLastUpdated: nil, widgetLastUpdated: nil))
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
