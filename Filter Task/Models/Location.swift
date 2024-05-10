//
//  Location.swift
//  Filter Task
//
//  Created by Vinoth Vino on 10/05/24.
//

import Foundation

struct Location: Decodable {
    var city: String
    var locations: [Taxonomy]
}
