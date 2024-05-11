//
//  FilterItem.swift
//  Filter Task
//
//  Created by Vinoth Vino on 11/05/24.
//

import Foundation

struct FilterItem: Identifiable {
    var id: String { slug }
    var name: String
    var slug: String
}
