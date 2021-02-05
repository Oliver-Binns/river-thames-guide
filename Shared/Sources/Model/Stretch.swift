//
//  Stretch.swift
//  iOS
//
//  Created by Laptop 3 on 03/02/2021.
//
import Foundation
import SwiftUI

public struct Stretch {
    public let name: String
    public let condition: String

    private let colourString: String?
    public var colour: Color {
        switch colourString {
        case "red":
            return .red
        case "yellow":
            return .yellow
        case "green":
            return .green
        default:
            return .primary
        }
    }

    public let lastUpdated: Date

    public init(name: String, condition: String, lastUpdated: Date) {
        self.name = name
        self.condition = condition
        self.colourString = nil
        self.lastUpdated = lastUpdated
    }
}
extension Stretch: Decodable {
    enum CodingKeys: String, CodingKey {
        case name = "stretch"
        case condition
        case colourString = "colour"
        case lastUpdated = "lastupdated"
    }
}
extension Stretch: Identifiable {
    public var id: String {
        name
    }
}
