//
//  SettingsModels.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 27.12.2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
