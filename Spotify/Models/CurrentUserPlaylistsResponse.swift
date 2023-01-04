//
//  CurrentUserPlaylistsResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 02.01.2023.
//

import Foundation

struct CurrentUserPlaylistsResponse: Codable {
 //   let href: String
    let items: [Playlist]
//    let limit: Int
//    let next: String?
//    let offset: Int
//    let previous: String?
//    let total: Int
}
