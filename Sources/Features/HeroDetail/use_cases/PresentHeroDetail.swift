import CoreDomainContracts
import LeanRedux
import Routing
import SwiftUI
import UIKit

/// sourcery: AutoMockable
@MainActor
public protocol PresentHeroDetailProtocol
{
    func callAsFunction(heroId: Int)
}

@MainActor
public struct PresentHeroDetail: PresentHeroDetailProtocol
{
    // MARK: Dependencies

    private let makeDismissMiddleware: MakeHeroDetailDismissMiddlewareProtocol
    private let makeLikeMiddleware: MakeHeroLikeMiddlewareProtocol
    private let makeLoadMiddleware: MakeHeroLoadMiddlewareProtocol
    private let navigator: NavigatorProtocol

    // MARK: Lifecycle

    public static func make(
        getHero: GetHeroProtocol,
        window: UIWindow
    ) -> PresentHeroDetailProtocol
    {
        PresentHeroDetail(
            makeDismissMiddleware: MakeHeroDismissMiddleware.make(),
            makeLikeMiddleware: MakeHeroLikeMiddleware.make(),
            makeLoadMiddleware: MakeHeroLoadMiddleware.make(getHero: getHero),
            navigator: Navigator.make(window: window)
        )
    }

    init(
        makeDismissMiddleware: MakeHeroDetailDismissMiddlewareProtocol,
        makeLikeMiddleware: MakeHeroLikeMiddlewareProtocol,
        makeLoadMiddleware: MakeHeroLoadMiddlewareProtocol,
        navigator: NavigatorProtocol
    )
    {
        self.makeDismissMiddleware = makeDismissMiddleware
        self.makeLikeMiddleware = makeLikeMiddleware
        self.makeLoadMiddleware = makeLoadMiddleware
        self.navigator = navigator
    }

    // MARK: Logic

    public func callAsFunction(heroId: Int)
    {
        var presentation: Presentation?
        let presentationProvider = { presentation }
        let view = HeroDetailView.make(
            heroId: heroId,
            middlewares: [
                makeDismissMiddleware(presentationProvider: presentationProvider),
                makeLikeMiddleware(),
                makeLoadMiddleware(),
            ]
        )
        let viewController = UIHostingController(rootView: view)
        presentation = navigator.presentModal(viewController, animated: true)
    }
}
