//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 30.12.2022.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height-4
        albumCoverImageView.frame = CGRect(x: 5,
                                           y: 2,
                                           width: imageSize,
                                           height: imageSize)
        
        trackNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                      y: 0,
                                      width: contentView.width-albumCoverImageView.right-15,
                                      height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                       y: contentView.height/2,
                                       width: contentView.width-albumCoverImageView.right-15,
                                       height: contentView.height/2)
    }
    
    // gets called whenever we reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // to ensure when we will reuse the cell we aren't leaking stage from the prior cell
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
