//
//  SortByView.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import SwiftUI

struct SortByView: View {
    @StateObject private var sortViewModel = SortViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Constants.sortBy)
                .font(.title2)
                .fontWeight(.bold)
            if sortViewModel.sortOptions != nil {
                LazyVStack(alignment: .leading) {
                    ForEach(sortViewModel.sortOptions!.taxonomy.getTaxonomies(isDefaultNeeded: true), id: \.slug) { item in
                        RadioListTile(title: item.name, isSelected: item.isSelected == true) {
                            sortViewModel.updateSortSelection(item: item)
                        }
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 14).fill(.white))
    }
}

