//
//  TubeStatusApp.swift
//  TubeStatus
//
//  Created by Oliver Binns on 24/06/2020.
//

import Shared
import SwiftUI

@main
struct TubeStatusApp: App {
    @State private var result: Result<Stretch, Error>?

    var body: some Scene {
        WindowGroup {
            VStack {
                ContentView(result: $result)
            }.onAppear {
                StatusService.getStatus(client: .init(), for: .marsh) { result in
                    DispatchQueue.main.async {
                        self.result = result
                    }
                }
            }
        }
    }
}
