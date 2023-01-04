//
//  UserProfile.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 16.12.2022.
//

import Foundation

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let product: String
    let images: [APIImage]
}

//{
//    country = KZ;
//    "display_name" = Olzhas;
//    "explicit_content" =     {
//        "filter_enabled" = 0;
//        "filter_locked" = 0;
//    };
//    "external_urls" =     {
//        spotify = "https://open.spotify.com/user/31f5ne3vadmurfnzgcsx5vz73v6q";
//    };
//    followers =     {
//        href = "<null>";
//        total = 0;
//    };
//    href = "https://api.spotify.com/v1/users/31f5ne3vadmurfnzgcsx5vz73v6q";
//    id = 31f5ne3vadmurfnzgcsx5vz73v6q;
//    images =     (
//    );
//    product = open;
//    type = user;
//    uri = "spotify:user:31f5ne3vadmurfnzgcsx5vz73v6q";
//}
