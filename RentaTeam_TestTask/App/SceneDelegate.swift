//
//  SceneDelegate.swift
//  RentaTeam_TestTask
//
//  Created by Александр Фомин on 16.03.2022.
//

import UIKit
import Kingfisher

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        ImageCache.default.memoryStorage.config.totalCostLimit = 1
        ImageCache.default.diskStorage.config.sizeLimit = 1024 * 1024 * 1024
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        self.window?.rootViewController = GalleryViewController(collectionViewLayout: flowLayout)
        
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
