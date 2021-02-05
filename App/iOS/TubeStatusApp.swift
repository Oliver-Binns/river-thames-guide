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
    var body: some Scene {
        WindowGroup {
            VStack {
                HomeView()
            }
        }
    }
}
