//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 16.12.2022.
//

import SDWebImage
import UIKit

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .link
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
        controlsView.delegate = self
        configureWithDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.width,
                                 height: view.width)
        controlsView.frame = CGRect(
            x: 0,
            y: imageView.bottom+5,
            width: view.width,
            height: view.height-imageView.bottom-view.safeAreaInsets.bottom
        )
        
    }
    
    private func configureWithDataSource() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
    }
    
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
}

extension PlayerViewController: PlayerControlsViewDelegate {
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    func playerControlsViewDidTapBackButton(_ playerControlsView: PlayerControlsView) {
        
    }
    
    
}
