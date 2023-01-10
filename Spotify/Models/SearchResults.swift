//
//  SearchResults.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 09.01.2023.
//

import Foundation

enum SearchResults {
    case album(model: Album)
    case artist(model: Artist)
    case playlist(model: Playlist)
    case track(model: AudioTrack)
}
