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
    private let navigator: NavigatorProtocol

    // MARK: Lifecycle

    public static func make(
        window: UIWindow
    ) -> PresentHeroDetailProtocol
    {
        PresentHeroDetail(
            makeDismissMiddleware: MakeHeroDetailDismissMiddleware.make(),
            navigator: Navigator.make(window: window)
        )
    }

    init(
        makeDismissMiddleware: MakeHeroDetailDismissMiddlewareProtocol,
        navigator: NavigatorProtocol
    )
    {
        self.makeDismissMiddleware = makeDismissMiddleware
        self.navigator = navigator
    }

    // MARK: Logic

    public func callAsFunction(heroId: Int)
    {
        var presentation: Presentation?
        let presentationProvider = { presentation }
        let dismissMiddleware = makeDismissMiddleware(presentationProvider: presentationProvider)
        let view = HeroDetailView.make(
            heroId: heroId,
            middlewares: [dismissMiddleware]
        )
        let viewController = UIHostingController(rootView: view)
        presentation = navigator.presentModal(viewController, animated: true)
    }
}
