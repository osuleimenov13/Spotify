//
//  CategoriesResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 07.01.2023.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: Categories
}

struct Categories: Codable {
    let items: [Category]
}

struct Category: Codable {
    let icons: [APIImage]
    let id: String
    let name: String
}
