//
//  FilterView.swift
//  Filter Task
//
//  Created by Vinoth Vino on 10/05/24.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var filterViewModel = FilterViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    SelectedFilterView(items: filterViewModel.selectedItems) { filterItem in
                        filterViewModel.removeItem(item: filterItem)
                    }
                    SortByView()
                    ExpandableListView()
                }
                .environmentObject(filterViewModel)
                .padding(.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle(Constants.navTitle)
            .background(.backgroundColor1)
        }
    }
}

fileprivate struct ExpandableListView: View {
    @EnvironmentObject private var filterViewModel: FilterViewModel
    
    var body: some View {
        LazyVStack {
            ForEach(filterViewModel.filterOptions) { option in
                CustomDisclosureGroup(option: option) { taxonomy in
                    filterViewModel.updateChipSelection(taxonomy: taxonomy)
                    filterViewModel.updateDisclosureGroup(taxonomy: taxonomy)
                }
            }
        }
    }
}

fileprivate struct CustomDisclosureGroup: View {
    var option: FilterOption
    var onItemTapped: (Taxonomy) -> Void
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded,
            content: {
                LazyVStack(alignment: .leading) {
                    ForEach(option.taxonomy.getTaxonomies(), id: \.slug) { item in
                        RadioListTile(title: item.name, isSelected: item.isSelected == true) {
                            onItemTapped(item)
                        }
                    }
                }
                .padding(.vertical)
            },
            label: {
                Text(option.name)
            }
        )
        .tint(.black)
        .padding(.vertical)
        .padding(.horizontal, 20)
        .background(RoundedRectangle(cornerRadius: 14).fill(.white))
    }
}

#Preview {
    FilterView()
        .preferredColorScheme(.light)
}
