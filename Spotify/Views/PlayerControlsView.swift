//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 12.01.2023.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackButton(_ playerControlsView: PlayerControlsView) // parameter is the view which is invoking the delegate
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Drip too hard"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Lil Baby"
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label // dark in white mode and white in dark mode
        let image = UIImage(systemName: "backward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label // dark in white mode and white in dark mode
        let image = UIImage(systemName: "forward.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label // dark in white mode and white in dark mode
        let image = UIImage(systemName: "pause", withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        
        clipsToBounds = true // for subviews to not overflow the edges of the view
        
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForwardButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        
        volumeSlider.frame = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height: 44) // standard height for slider
        
        let buttonSize: CGFloat = 60
        playPauseButton.frame = CGRect(x: (width-buttonSize)/2, y: volumeSlider.bottom+(height-volumeSlider.bottom-buttonSize)/2, width: buttonSize, height: buttonSize)
        backButton.frame = CGRect(x: playPauseButton.left-buttonSize-80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        forwardButton.frame = CGRect(x: playPauseButton.right+80, y: playPauseButton.top, width: buttonSize, height: buttonSize)
        
    }
    
    @objc private func didTapBackButton() {
        delegate?.playerControlsViewDidTapBackButton(self)
    }
    
    @objc private func didTapForwardButton() {
        delegate?.playerControlsViewDidTapForwardButton(self)
    }
    
    @objc private func didTapPlayButton() {
        delegate?.playerControlsViewDidTapPlayPauseButton(self)
    }
}
