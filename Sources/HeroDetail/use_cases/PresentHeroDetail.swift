import Routing
import SwiftUI
import UIKit

@MainActor
public protocol PresentHeroDetailProtocol
{
    func callAsFunction(heroId: Int)
}

@MainActor
public struct PresentHeroDetail: PresentHeroDetailProtocol
{
    // MARK: Dependencies

    private let navigator: NavigatorProtocol

    // MARK: Lifecycle

    public static func make(window: UIWindow) -> PresentHeroDetailProtocol
    {
        PresentHeroDetail(navigator: Navigator.make(window: window))
    }

    public func callAsFunction(heroId: Int)
    {
        let view = HeroDetailView.make(heroId: heroId)
        let viewController = UIHostingController(rootView: view)
        _ = navigator.presentModal(viewController, animated: true)
    }
}
