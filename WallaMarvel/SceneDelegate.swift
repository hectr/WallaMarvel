import Data
import Domain
import HeroDetail
import HeroList
import SwiftUI
import UIKit
import Domain

final class SceneDelegate: UIResponder, UIWindowSceneDelegate
{
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions:
        UIScene.ConnectionOptions
    )
    {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        let window = UIWindow(windowScene: windowScene)
        let viewController = Self.makeRoot(window: window)

        Self.configureWindow(
            rootViewController: viewController,
            window: window
        )
    }

    /// Composition Root.
    private static func makeRoot(window: UIWindow) -> UIViewController
    {
        let repository = MarvelRepository.make(dataSource: MarvelRemoteDataSource.make())
        let listHeroesViewController = ListHeroesViewController.make(
            presenter: ListHeroesPresenter.make(
                getHeroes: GetHeroes.make(repository: repository)
            ),
            presentDetail: PresentHeroDetail.make(
                getHero: GetHero.make(repository: repository),
                window: window
            ).callAsFunction(heroId:)
        )
        return listHeroesViewController
    }

    /// Sets window's content and makes it visible.
    private static func configureWindow(
        rootViewController: UIViewController,
        window: UIWindow
    )
    {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
