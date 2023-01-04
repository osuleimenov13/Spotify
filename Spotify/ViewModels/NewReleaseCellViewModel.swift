//
//  NewReleaseCellViewModel.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 30.12.2022.
//

import Foundation

// the content we need to pass to our cell
struct NewReleaseCellViewModel {
    let name: String
    let artworkURL: URL?
    let numberOfTracks: Int
    let artistName: String
}
