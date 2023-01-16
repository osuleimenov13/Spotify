//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 16.12.2022.
//

import UIKit

class LibraryViewController: UIViewController {
    
    private let playlistsVC = LibraryPlaylistsViewController()
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.delegate = self
        scrollView.backgroundColor = .systemMint
        scrollView.contentSize = CGSize(width: view.width*2, height: scrollView.height)
        view.addSubview(scrollView)
        toggleView.delegate = self
        view.addSubview(toggleView)
        addChildren()
        updateBarButtons()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top+55,
            width: view.width,
            height: view.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-55
        )
        
        toggleView.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: 200,
            height: 55
        )
        
    }

    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.didMove(toParent: self)
    }
    
    private func updateBarButtons() {
        switch toggleView.state {
        case .playlists:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddPlaylist))
        case .albums:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func didTapAddPlaylist() {
        playlistsVC.showCreatePlaylistAlert()
    }
}

extension LibraryViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= view.width-100 {
            toggleView.update(for: .albums)
            updateBarButtons()
        }
        else {
            toggleView.update(for: .playlists)
            updateBarButtons()
        }
    }
    
}

extension LibraryViewController: LibraryToggleViewDelegate {
    
    func libraryToggleViewDidTapPlaylistsButton(_ libraryToggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbumsButton(_ libraryToggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
    
}
