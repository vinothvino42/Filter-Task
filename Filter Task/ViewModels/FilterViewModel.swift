//
//  FilterViewModel.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import Foundation

class FilterViewModel: ObservableObject {
    @Published var selectedItems: [FilterItem] = []
    @Published var filterOptions: [FilterOption] = FilterResponse.getFilters()
    
    /// Updates the chip (Add or Remove)
    func updateChipSelection(taxonomy: Taxonomy) {
        let filterItem = FilterItem(name: taxonomy.name, slug: taxonomy.slug)
        if !(taxonomy.isSelected == true) {
            addItem(item: filterItem)
        } else {
            removeItem(item: filterItem)
        }
    }
    
    /// Update the disclosure group selection
    func updateDisclosureGroup(taxonomy: Taxonomy) {
        updateTaxonomies(slug: taxonomy.slug, isSelected: taxonomy.isSelected == true)
    }
    
    private func addItem(item: FilterItem) {
        let isContains = selectedItems.contains { $0.slug == item.slug }
        if (!isContains) {
            selectedItems.append(item)
        }
    }
    
    func removeItem(item: FilterItem) {
        selectedItems.removeAll { $0.name == item.name }
        updateTaxonomies(slug: item.slug, isSelected: true)
    }
    
    private func updateTaxonomies(slug: String, isSelected: Bool) {
        for (filterIndex, _) in filterOptions.enumerated() {
            if case .taxonomy(var lists) = filterOptions[filterIndex].taxonomy {
                for (index, _) in lists.enumerated() {
                    if (lists[index].slug == slug) {
                        lists[index].isSelected = !(isSelected == true)
                    }
                }
                
                // Updating with new selected states
                filterOptions[filterIndex].taxonomy = TaxononmyResponse.taxonomy(data: lists)
            } else if case .location(var taxonomies) = filterOptions[filterIndex].taxonomy {
                var allLocTaxonomies = taxonomies.flatMap { $0.locations }
                for (taxonomyIndex, value) in taxonomies.enumerated() {
                    for (index, location) in value.locations.enumerated() {
                        if (location.slug == slug) {
                            allLocTaxonomies[index].isSelected = !(isSelected == true)
                            taxonomies[taxonomyIndex].locations = allLocTaxonomies
                        }
                    }
                }
                
                // Updating with new selected states
                filterOptions[filterIndex].taxonomy = TaxononmyResponse.location(data: taxonomies)
            }
        }
    }
}
