//
//  FilterOption.swift
//  Filter Task
//
//  Created by Vinoth Vino on 10/05/24.
//

import Foundation

struct FilterResponse: Decodable {
    var data: [FilterOption]
    
    static func getFilters() -> [FilterOption] {
        let allFilters = getAllFilters() ?? []
        let filteredItems = allFilters.filter { $0.slug != "sort" }
        return filteredItems
    }
    
    static func getSortedOption() -> FilterOption? {
        let allFilters = getAllFilters() ?? []
        let sortItem = allFilters.first { $0.slug == "sort" }
        return sortItem
    }
    
    static private func getAllFilters() -> [FilterOption]? {
        if let url = Bundle.main.url(forResource: "filters", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let filterResponse = try decoder.decode(FilterResponse.self, from: data)
                return filterResponse.data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    
}

struct FilterOption: Identifiable, Decodable {
    var id: String { slug }
    var name: String
    var slug: String
    var taxonomy: TaxononmyResponse
    
    enum FilterOptionCodingKeys: String, CodingKey {
        case name, slug, taxonomies
    }
}

extension FilterOption {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: FilterOptionCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        
        if let locations = try? container.decode([Location].self, forKey: .taxonomies) {
            taxonomy = .location(data: locations)
        } else if let taxonomies = try? container.decode([Taxonomy].self, forKey: .taxonomies) {
            taxonomy = .taxonomy(data: taxonomies)
        } else {
            throw FilterDecodingError.corrupted
        }
    }
}

enum TaxononmyResponse {
    case taxonomy(data: [Taxonomy])
    case location(data: [Location])
}

extension TaxononmyResponse {
    func getTaxonomies(isDefaultNeeded: Bool = false) -> [Taxonomy] {
        if case .taxonomy(var lists) = self {
            let isAnyItemNotSelected = lists.filter { $0.isSelected == true }.isEmpty
            
            // Setting first item as default one
            if (isAnyItemNotSelected && isDefaultNeeded) {
                lists[0].isSelected = true
            }
            return lists
        } else if case .location(let lists) = self {
            let allTaxonomies = lists.flatMap { $0.locations }
            return allTaxonomies
        }
        return []
    }
}

enum FilterDecodingError: Error {
    case corrupted
}

// Model Diff
/*
 1. id?, guid?, slug, name (index 0 - 4)
 2. slug, name (6 and 7)
 3. city, locations (id, guid, slug, name)
 */
