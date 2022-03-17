//
//  Builder.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 17.03.2022.
//

import UIKit
import Kingfisher

final class Builder {
    static func makeWindow() -> UIWindow {
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
        ImageCache.default.diskStorage.config.sizeLimit = 1024 * 1024 * 1024

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let galleryViewController = GalleryViewController(collectionViewLayout: flowLayout)
        galleryViewController.imagesService = ImagesService()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = galleryViewController
        return window
    }
}
