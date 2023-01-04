//
//  Playlist.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 16.12.2022.
//

import Foundation

struct Playlist: Codable {
//    let collaborative: Bool
    let description: String
    let external_urls: [String: String]
//    let href: String
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
//    let tracks: Track
//    let type: String
//    let uri: String
}

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
//    let href: String
    let id: String
//    let type: String
//    let uri: String
}

struct Track: Codable {
    let href: String
    let total: Int
}
