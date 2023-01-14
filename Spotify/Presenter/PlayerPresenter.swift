//
//  PlayerPresenter.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 10.01.2023.
//

import AVFoundation
import Foundation
import UIKit

final class PlayerPresenter {
    
    static let shared = PlayerPresenter()
    
    // Model
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack? {
        if let track = track, tracks.isEmpty {
            return track
        }
        else if let player = queuePlayer, !tracks.isEmpty {
            return tracks[index]
        }
        
        return nil
    }
    
    var player: AVPlayer?
    var queuePlayer: AVQueuePlayer?
    var playerVC: PlayerViewController?
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        if let url = URL(string: track.preview_url ?? "") {
            player = AVPlayer(url: url)
            player?.volume = 0.5
        }
        
        self.track = track
        self.tracks = []
        
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self // to pass actual song name and artist
        vc.delegate = self // to make actual implementation when user taps buttons in player
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        self.tracks = tracks
        self.track = nil
        
        let items: [AVPlayerItem] = tracks.compactMap {
            guard let url = URL(string: $0.preview_url ?? "") else {
                return nil
            }
            return AVPlayerItem(url: url)
        }
        queuePlayer = AVQueuePlayer(items: items)
        queuePlayer?.volume = 0.5
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true) { [weak self] in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
}

extension PlayerPresenter: PlayerViewControllerDelegate {
    
    func didTapPlayPause() {
        if let player = player {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
        else if let player = queuePlayer {
            if player.timeControlStatus == .playing {
                player.pause()
            }
            else if player.timeControlStatus == .paused {
                player.play()
            }
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
        }
        else {
            queuePlayer?.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapBackward() {
        if tracks.isEmpty {
            // Not playlist or album
            player?.pause()
            player?.play()
        }
        else {
            queuePlayer?.pause()
        }
    }
    
    func didChangeSliderTo(_ value: Float) {
        player?.volume = value
    }
}

extension PlayerPresenter: PlayerDataSource {
    
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
}
