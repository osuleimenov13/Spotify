//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 15.01.2023.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylistsButton(_ libraryToggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbumsButton(_ libraryToggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlists
        case albums
    }
    
    var state: State = .playlists
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    @objc private func didTapPlaylists() {
        state = .playlists
        delegate?.libraryToggleViewDidTapPlaylistsButton(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
    
    @objc private func didTapAlbums() {
        state = .albums
        delegate?.libraryToggleViewDidTapAlbumsButton(self)
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistButton.right, y: 0, width: 100, height: 40)
        
        layoutIndicator()
    }
    
    private func layoutIndicator() {
        switch state {
        case .playlists:
            indicatorView.frame = CGRect(x: 0, y: playlistButton.bottom, width: 100, height: 3)
        case .albums:
            indicatorView.frame = CGRect(x: 100, y: playlistButton.bottom, width: 100, height: 3)
        }
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
