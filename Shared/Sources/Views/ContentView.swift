//
//  ContentView.swift
//  iOS
//
//  Created by Laptop 3 on 03/02/2021.
//
import SwiftUI

public struct ContentView: View {
    @Binding var result: Result<[Stretch], Error>?

    public init(result: Binding<Result<[Stretch], Error>?>) {
        self._result = result
    }

    public var body: some View {
        VStack(spacing: 4) {
            switch result {
            case .success(let stretches):
                ForEach(stretches) {
                    StretchView(stretch: $0)
                }
            case .failure(let error):
                Text(error.localizedDescription)
            default:
                Text("Loading...")
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StretchView(stretch: .init(name: "Test",
                                   condition: "Test 2",
                                   lastUpdated: .init()))
    }
}
