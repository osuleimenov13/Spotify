//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 03.01.2023.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String] // so we can f.e. share album by url
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let popularity: Int
    let release_date: String
    let total_tracks: Int
    let tracks: TracksResponse
}

struct TracksResponse: Codable {
    let items: [AudioTrack]
}
