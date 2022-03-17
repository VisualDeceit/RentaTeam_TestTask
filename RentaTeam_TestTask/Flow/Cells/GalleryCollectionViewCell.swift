//
//  GalleryCollectionViewCell.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit
import Kingfisher

class GalleryViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GalleryCollectionViewCell"
    
    private let imageView = UIImageView()
    private let blackoutView = UIView()
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(url: String, user: String, date: String, likes: Int) {
        self.backgroundColor = .white
        setupViews()
        imageView.kf.setImage(with: URL(string: url))
        userLabel.text = user
        dateLabel.text = date
        likesLabel.text = "♥ \(likes)"
    }
    
    private func setupViews() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
              imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.addSubview(blackoutView)
        blackoutView.translatesAutoresizingMaskIntoConstraints = false
        blackoutView.backgroundColor =  UIColor(white: 0, alpha: 0.7)
        NSLayoutConstraint.activate([
            blackoutView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor, multiplier: 0.2),
            blackoutView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blackoutView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            blackoutView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        blackoutView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: blackoutView.bottomAnchor, constant: -4),
            dateLabel.leadingAnchor.constraint(equalTo: blackoutView.leadingAnchor, constant: 4),
            dateLabel.widthAnchor.constraint(equalTo: blackoutView.widthAnchor, multiplier: 0.5)
        ])
        
        blackoutView.addSubview(userLabel)
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: blackoutView.topAnchor, constant: 4),
            userLabel.leadingAnchor.constraint(equalTo: blackoutView.leadingAnchor, constant: 4),
            userLabel.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -4),
            userLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4),
        ])

        blackoutView.addSubview(likesLabel)
        NSLayoutConstraint.activate([
            likesLabel.bottomAnchor.constraint(equalTo: blackoutView.bottomAnchor, constant: -4),
            likesLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            likesLabel.trailingAnchor.constraint(equalTo: blackoutView.trailingAnchor, constant: -4),
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    
        imageView.kf.cancelDownloadTask()
        imageView.image = nil
    }
}
