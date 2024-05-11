//
//  SelectedFilterView.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import SwiftUI

struct SelectedFilterView: View {
    var items: [FilterItem]
    var onCloseTapped: (FilterItem) -> ()
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(items) { item in
                    HStack {
                        Button {
                            onCloseTapped(item)
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.black)
                        }
                        Text(item.name)
                            .font(.subheadline)
                    }
                    .font(.caption)
                    .padding(.horizontal)
                    .padding(.vertical, 6)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.chip)
                    )
                }
            }
        }
        .padding(.vertical, 4)
    }
}
