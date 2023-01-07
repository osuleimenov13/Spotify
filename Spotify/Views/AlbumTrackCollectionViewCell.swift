//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 06.01.2023.
//

import UIKit

class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendedTrackCollectionViewCell"
    
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
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackNameLabel.frame = CGRect(x: 10,
                                      y: 0,
                                      width: contentView.width-20,
                                      height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: contentView.height/2,
                                       width: contentView.width-20,
                                       height: contentView.height/2)
    }
    
    // gets called whenever we reuse cell
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // to ensure when we will reuse the cell we aren't leaking stage from the prior cell
        trackNameLabel.text = nil
        artistNameLabel.text = nil
    }
    
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}
