//
//  Recipe.swift
//  HelloFreshCoding
//
//  Created by Waqas Naseem on 10/28/21.
//

import Foundation

struct Recipe: Decodable {
    let id: String
    let name: String
    let headline: String
    let image: String
    let preparationMinutes: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, headline, image, preparationMinutes = "preparation_minutes"
    }
}
