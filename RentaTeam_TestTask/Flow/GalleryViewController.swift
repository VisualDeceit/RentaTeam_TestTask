//
//  GalleryViewController.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit

class GalleryViewController: UICollectionViewController {
    
    private enum Constants {
        static let cellSpacing: CGFloat = 10
    }
    
    private var nextPage = 1
    private var isLoading = false
    private var imagesData = [ImageData]()
    private let imagesService = ImagesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(GalleryViewCell.self,
                                     forCellWithReuseIdentifier: GalleryViewCell.reuseIdentifier)
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .white

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryViewCell.reuseIdentifier,
                                                            for: indexPath) as? GalleryViewCell else {
            return UICollectionViewCell()
        }
        
        let imageViewData = convertDateToViewModel(data: imagesData[indexPath.row])
        cell.configure(with: imageViewData)
        return cell
    }
    
    private func convertDateToViewModel(data: ImageData) -> ImageViewData {
        let isoDateFormatter = ISO8601DateFormatter()
        let date = isoDateFormatter.date(from: data.created) ?? Date()
        let localDateFormatter = DateFormatter.shortLocalStyle
        
        return .init(stringUrl: data.urls.thumb,
                     userName: data.user.name,
                     date: localDateFormatter.string(from: date),
                     likes: "\(data.likes)")
    }
    
// MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.stringURL = imagesData[indexPath.row].urls.regular
        present(imageDetailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
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

extension GalleryViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let maxItem = indexPaths.max()?.item else { return }
        
        if maxItem > imagesData.count - 4, !isLoading {
            isLoading = true
            
            imagesService.requestData(page: nextPage) { [weak self] result in
                switch result {
                case .success(let data):
                    guard let self = self else { return }
                    self.nextPage += 1
                    let indexPath = (self.imagesData.count..<self.imagesData.count + data.count).map { IndexPath(row: $0, section: 0) }
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
