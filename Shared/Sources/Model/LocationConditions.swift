//
//  LocationConditions.swift
//  Shared
//
//  Created by Laptop 3 on 24/12/2020.
//
import Foundation

public struct LocationConditions: Codable {
    let title: String

    let conditions: [Condition]

    let feedLastUpdated: Date?
    let widgetLastUpdated: Date?

    public static var placeholder: LocationConditions {
        .init(title: "Loading...",
              conditions: [],
              feedLastUpdated: nil,
              widgetLastUpdated: nil)
    }
}

public struct Condition: Codable, Identifiable {
    public let id: UUID
    let reach: String
    let condition: String
    let lastChange: String
}

