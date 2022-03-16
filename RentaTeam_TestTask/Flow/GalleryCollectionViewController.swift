//
//  GalleryCollectionViewController.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit

class GalleryCollectionViewController: UICollectionViewController {
    
    private enum Constants {
        static let cellSpacing: CGFloat = 10
    }
    
    private var nextPage = 1
    private var isLoading = false
    private var imagesData = [ImageData]()
    private let imagesService = ImagesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(GalleryCollectionViewCell.self,
                                     forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseIdentifier)
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .yellow

        imagesService.requestData(page: nextPage) { [weak self] result in
            switch result {
            case .success(let data):
                self?.nextPage += 1
                self?.imagesData.append(contentsOf: data)
                self?.collectionView.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesData.count
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

// MARK: - UICollectionViewDataSourcePrefetching

extension GalleryCollectionViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxItem = indexPaths.max()?.item else { return }
        
        if maxItem > imagesData.count - 4, !isLoading {
            isLoading = true
            
            imagesService.requestData(page: nextPage) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let self = self else { return }
                    self.nextPage += 1
                    let indexPath = (self.imagesData.count..<self.imagesData.count + data.count)
                        .map { IndexPath(row: $0, section: 0) }
                    self.imagesData.append(contentsOf: data)
                    self.collectionView.insertItems(at: indexPath)
                    self.isLoading = false
                case .failure(let error):
                    debugPrint(error)
                }
            }
        }
    }
}
