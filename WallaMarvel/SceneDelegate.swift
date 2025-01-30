import HeroDetail
import HeroList
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        let listHeroesViewController = ListHeroesViewController.make(
            presentDetail: PresentHeroDetail.make(window: window).callAsFunction(heroId:)
        )

        let navigationController = UINavigationController(rootViewController: listHeroesViewController)
        window.rootViewController = navigationController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

