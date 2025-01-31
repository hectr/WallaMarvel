@testable import HeroDetail
@testable import HeroDetailTestSupport
@testable import RoutingTestSupport
import SwiftUI
import Testing

@Suite @MainActor
final class PresentHeroDetailTests
{
    @Test("When called presents a hosting controller with dismiss middleware")
    func hostingController()
    {
        // Given
        let navigator = NavigatorProtocolMock()
        let makeDismiss = MakeHeroDetailDismissMiddlewareProtocolMock()
        makeDismiss.callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareReturnValue = { _, _ in nil }
        let makeLike = MakeHeroLikeMiddlewareProtocolMock()
        makeLike.callAsFunctionHeroDetailFeatureStoreMiddlewareReturnValue = { _, _ in nil }
        let makeLoad = MakeHeroLoadMiddlewareProtocolMock()
        makeLoad.callAsFunctionHeroDetailFeatureStoreMiddlewareReturnValue = { _, _ in nil }
        let sut = PresentHeroDetail(
            makeDismissMiddleware: makeDismiss,
            makeLikeMiddleware: makeLike,
            makeLoadMiddleware: makeLoad,
            navigator: navigator
        )

        // When
        sut(heroId: 1)

        // Then
        let makeDismissCallsCount = makeDismiss
            .callAsFunctionPresentationProviderEscapingPresentationHeroDetailFeatureStoreMiddlewareCallsCount
        let presentModalCallsCount = navigator
            .presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationCallsCount
        let presentModalArguments = navigator
            .presentModalViewControllerToPresentUIViewControllerAnimatedBoolPresentationReceivedArguments
        #expect(makeDismissCallsCount == 1)
        #expect(presentModalCallsCount == 1)
        #expect(String(describing: presentModalArguments?.viewControllerToPresent).contains("UIHostingController"))
        #expect(presentModalArguments!.animated == true)
    }
}
