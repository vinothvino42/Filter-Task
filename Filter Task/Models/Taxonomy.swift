//
//  Taxonomy.swift
//  Filter Task
//
//  Created by Vinoth Vino on 10/05/24.
//

import Foundation

struct Taxonomy: Identifiable, Decodable {
    var id: Int?
    var guid: String?
    var name: String
    var slug: String
    var isSelected: Bool? = false
    
    enum TaxonomyCodingKeys: String, CodingKey {
        case guid = "Guid", id, name, slug, isSelected
    }
}
