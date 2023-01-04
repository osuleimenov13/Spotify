//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 30.12.2022.
//

import UIKit
import SDWebImage

//struct NewReleaseCellViewModel {
//    let name: String
//    let artworkURL: URL?
//    let numberOfTracks: Int
//    let artistName: String
//}

class NewReleaseCollectionViewCell: UICollectionViewCell {
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(numberOfTracksLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height-10
        let albumLabelSize = albumNameLabel.sizeThatFits(CGSize(width: contentView.width-imageSize-10,
                                                                height: contentView.height-10))
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        
        // Image
        albumCoverImageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
        
        // Album name label
        let albumLabelHeight = min(60, albumLabelSize.height)
        albumNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                      y: 5,
                                      width: albumLabelSize.width,
                                      height: albumLabelHeight)
        
        // Artist name label
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                       y: albumNameLabel.bottom,
                                       width: contentView.width-albumCoverImageView.right-10,
                                       height: 30)
        
        // Number of tracks label
        numberOfTracksLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                           y: contentView.bottom-44,
                                           width: numberOfTracksLabel.width, // since we did sizToFit()
                                           height: 44)
    }
    
    // gets called whenever we reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // to ensure when we will reuse the cell we aren't leaking stage from the prior cell
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: NewReleaseCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
