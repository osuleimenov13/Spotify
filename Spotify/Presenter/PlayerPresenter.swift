//
//  PlayerPresenter.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 10.01.2023.
//

import Foundation
import UIKit

protocol PlayerDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
}

final class PlayerPresenter {
    
    static let shared = PlayerPresenter()
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
