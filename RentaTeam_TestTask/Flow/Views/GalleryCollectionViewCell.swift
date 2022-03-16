//
//  GalleryCollectionViewCell.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GalleryCollectionViewCell"
    
    func configure() {
        self.backgroundColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
