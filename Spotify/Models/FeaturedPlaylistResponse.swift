//
//  FeaturedPlaylistResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 28.12.2022.
//

import Foundation

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct CategoryPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}
