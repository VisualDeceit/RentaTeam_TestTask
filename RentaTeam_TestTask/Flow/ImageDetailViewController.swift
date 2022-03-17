//
//  ImageDetailViewController.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 17.03.2022.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {
    
    var stringURL: String? {
        didSet {
            loadImage(from: stringURL)
        }
    }
    
    private let imageView = UIImageView()
    
    private let cachedDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.imageView.addSubview(cachedDateLabel)
        
        NSLayoutConstraint.activate([
            cachedDateLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -4),
            cachedDateLabel.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 4),
            cachedDateLabel.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor)
        ])
    }
    
    private func loadImage(from url: String?) {
        guard let stringURL = url else { return }
        
        let dateFormatter = DateFormatter.longLocalStyle
        
        if ImageCache.default.isCached(forKey: stringURL) {
            let cachePath = ImageCache.default.cachePath(forKey: stringURL)
            
            if let attributes = try? FileManager.default.attributesOfItem(atPath: cachePath) as [FileAttributeKey: Any],
               let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
                cachedDateLabel.text = "Downloaded: " + dateFormatter.string(from: creationDate)
            }
            
            let urlPath = URL(fileURLWithPath: cachePath)
            let resource = ImageResource(downloadURL: urlPath, cacheKey: cachePath)
            imageView.kf.setImage(with: resource)
            
        } else {
            imageView.kf.setImage(with: URL(string: stringURL))
            cachedDateLabel.text = "Downloaded: " + dateFormatter.string(from: Date())
        }
    }
}
