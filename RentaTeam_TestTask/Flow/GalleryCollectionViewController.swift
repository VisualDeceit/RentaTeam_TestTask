//
//  GalleryCollectionViewController.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    
    enum Constants {
        static let cellSpacing: CGFloat = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(GalleryCollectionViewCell.self,
                                     forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .yellow
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier,
                                                            for: indexPath) as? GalleryCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure()
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 2
        let paddingWidth = Constants.cellSpacing * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem =  availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.cellSpacing,
                            left: Constants.cellSpacing,
                            bottom: Constants.cellSpacing,
                            right: Constants.cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}
