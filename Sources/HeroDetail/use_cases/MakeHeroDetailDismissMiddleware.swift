import LeanRedux
import Routing
import SwiftUI
import UIKit

/// sourcery: AutoMockable
@MainActor
protocol MakeHeroDetailDismissMiddlewareProtocol
{
    func callAsFunction(presentationProvider: @escaping () -> Presentation?) -> HeroDetailFeature.Store.Middleware
}

@MainActor
public struct MakeHeroDetailDismissMiddleware: MakeHeroDetailDismissMiddlewareProtocol
{

    // MARK: Lifecycle

    static func make() -> MakeHeroDetailDismissMiddlewareProtocol
    {
        MakeHeroDetailDismissMiddleware()
    }

    // MARK: Logic

    func callAsFunction(
        presentationProvider: @escaping () -> Presentation?
    ) -> HeroDetailFeature.Store.Middleware
    {
        return { action, _ in
            if action == .dismiss {
                Self.dismiss(presentationProvider: presentationProvider)
            }
            return nil
        }
    }

    private static func dismiss(
        presentationProvider: @escaping () -> Presentation?
    ) {
        guard let presentation = presentationProvider() else {
            assertionFailure("Presentation late binding failed")
            return
        }
        presentation.close(animated: true)
    }
}
