//
//  RecommendationsResponse.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 30.12.2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
