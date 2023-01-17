//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 17.01.2023.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
