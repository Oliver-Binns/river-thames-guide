//
//  StatusViewModel.swift
//  TFLStatus
//
//  Created by Oliver Binns on 24/06/2020.
//
import Combine
import Foundation

public final class StatusViewModel: ObservableObject {
    @Published public var conditions: LocationConditions = .placeholder

    public init(client: NetworkClient) {
        StatusService.getStatus(client: client, for: .marsh) { [weak self] conditions in
            DispatchQueue.main.async {
                self?.conditions = conditions
            }
        }
    }
}
