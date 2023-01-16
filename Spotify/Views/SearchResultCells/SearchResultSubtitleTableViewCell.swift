//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Olzhas Suleimenov on 10.01.2023.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {

    static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconImageView)
        contentView.addSubview(subtitleLabel)
        contentView.clipsToBounds = true // to make sure nothing overflows
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height-10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
//        iconImageView.layer.cornerRadius = imageSize/2
//        iconImageView.layer.masksToBounds = true
        
        label.frame = CGRect(x: iconImageView.right+10,
                             y: 0,
                             width: contentView.width-iconImageView.right-20,
                             height: contentView.height/2)
        
        subtitleLabel.frame = CGRect(x: iconImageView.right+10,
                                     y: contentView.height/2,
                                     width: contentView.width-iconImageView.right-20,
                                     height: contentView.height/2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subTitle
        iconImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: UIImage(systemName: "photo"), completed: nil)
    }
}
