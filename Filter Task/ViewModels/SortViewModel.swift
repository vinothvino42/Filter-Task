//
//  SortViewModel.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import Foundation

class SortViewModel: ObservableObject {
    @Published var sortOptions: FilterOption? = FilterResponse.getSortedOption()
    
    func updateSortSelection(item: Taxonomy) {
        guard sortOptions != nil else { return }
        if case .taxonomy(var lists) = sortOptions!.taxonomy {
            for (index, value) in lists.enumerated() {
                lists[index].isSelected = value.slug == item.slug
            }
            
            // Updating with new selected states
            sortOptions?.taxonomy = TaxononmyResponse.taxonomy(data: lists)
        }
    }
}
