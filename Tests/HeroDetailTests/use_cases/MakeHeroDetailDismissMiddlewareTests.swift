@testable import HeroDetail
@testable import HeroDetailTestSupport
@testable import Routing
@testable import RoutingTestSupport
import SwiftUI
import Testing

@MainActor
final class MakeHeroDetailDismissMiddlewareTests
{
    @Test("When created middleware receives 'dismiss' action, it has no follow up action")
    func followUpAction() async
    {
        // Given
        let sut = MakeHeroDetailDismissMiddleware()

        // When
        let middleware = sut(presentationProvider: {
            Presentation(for: UIViewController(), closeBlock: { _, _ in })
        })
        let followUp = await middleware(.dismiss, .init())

        // Then
        #expect(followUp == nil)
    }

    @Test("When created middleware receives 'dismiss' action, it closes presentation")
    func close() async throws
    {
        // Given
        let sut = MakeHeroDetailDismissMiddleware()
        let viewController = UIViewController()
        var closeBlockCallsCount = 0
        var receivedViewController = UIViewController?.none
        var receivedAnimated = Bool?.none
        let presentation = Presentation(
            for: viewController,
            closeBlock: { viewController, animated in
                closeBlockCallsCount += 1
                receivedViewController = viewController
                receivedAnimated = animated
            }
        )

        // When
        let middleware = sut(presentationProvider: {
            return presentation
        })
        try #require(closeBlockCallsCount == 0)
        _ = await middleware(.dismiss, .init())

        // Then
        #expect(closeBlockCallsCount == 1)
        #expect(receivedViewController === viewController)
        #expect(receivedAnimated == true)
    }

    @Test("When created middleware receives other actions, it skips them")
    func otherActions() async throws
    {
        // Given
        let sut = MakeHeroDetailDismissMiddleware()
        let viewController = UIViewController()
        var closeBlockCallsCount = 0
        var receivedViewController = UIViewController?.none
        var receivedAnimated = Bool?.none
        let presentation = Presentation(
            for: viewController,
            closeBlock: { viewController, animated in
                closeBlockCallsCount += 1
                receivedViewController = viewController
                receivedAnimated = animated
            }
        )

        // When
        let middleware = sut(presentationProvider: {
            return presentation
        })
        for action in HeroDetailFeature.Action.allCases.filter({ $0 != .dismiss }) {
            let followUp = await middleware(action, .init())
            try #require(followUp == nil)
            try #require(receivedViewController == nil)
            try #require(receivedAnimated == nil)
        }

        // Then
        #expect(closeBlockCallsCount == 0)
    }
}
