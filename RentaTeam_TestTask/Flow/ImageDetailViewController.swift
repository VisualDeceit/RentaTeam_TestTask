//
//  ImageDetailViewController.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 17.03.2022.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {

    private let imageView = UIImageView()
    
    var url: String? {
        didSet {
            imageView.kf.setImage(with: URL(string: url!))
        }
    }
    
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
    }
}
