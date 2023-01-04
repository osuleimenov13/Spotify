//
//  CurrentUserPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 03.01.2023.
//

import UIKit

class CurrentUserPlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "CurrentUserPlaylistsCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        creatorNameLabel.frame = CGRect(x: 3,
                                        y: contentView.height-40,
                                        width: contentView.width-6,
                                        height: 30)
        
        playlistNameLabel.frame = CGRect(x: 3,
                                        y: contentView.height-60,
                                        width: contentView.width-6,
                                        height: 30)
        
        let imageSize = contentView.height-70
        playlistCoverImageView.frame = CGRect(x: (contentView.width-imageSize)/2,
                                              y: 3,
                                              width: imageSize,
                                              height: imageSize)
    }
    
    // gets called whenever we reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // to ensure when we will reuse the cell we aren't leaking stage from the prior cell
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: CurrentUserPlaylistsCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.creatorName
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
