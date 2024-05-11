//
//  RadioListTile.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import SwiftUI

struct RadioListTile: View {
    var title: String
    var isSelected: Bool
    var onTapped: () -> Void
    
    var body: some View {
        Button {
            onTapped()
        } label: {
            Image(isSelected == true ? "radio_btn_checked" : "radio_btn_unchecked")
            Text(title)
                .foregroundStyle(isSelected == true ? Color.accentColor : Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 2)
        .tint(isSelected == true ? .accentColor : .gray)
    }
}

#Preview {
    RadioListTile(title: "Trending", isSelected: true) {
        print("Tapped")
    }
}

#Preview {
    RadioListTile(title: "Latest", isSelected: false) {
        print("Tapped")
    }
}
