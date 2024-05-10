//
//  FilterView.swift
//  Filter Task
//
//  Created by Vinoth Vino on 10/05/24.
//

import SwiftUI

struct FilterView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle(Constants.navTitle)
        }
        .onAppear {
            let filters = FilterResponse.getAllFilters()
            print("Filters Data: \(String(describing: filters))")
        }
    }
}

#Preview {
    FilterView()
}
