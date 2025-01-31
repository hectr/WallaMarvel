@testable import HeroDetail
@testable import HeroDetailTestSupport
import Testing

@Suite @MainActor
struct MakeHeroLikeMiddlewareTests {
    
    @Test("When created middleware receives 'like' action, it stores the liked state")
    func storeLikeState() async {
        // Given
        let userDefaults = PersistentStoreProtocolMock()
        let sut = MakeHeroLikeMiddleware(userDefaults: userDefaults)
        let middleware = sut()
        let heroId = 1
        let state = HeroDetailFeature.State(liked: true, selectedHeroId: heroId)

        // When
        _ = await middleware(.like, state)

        // Then
        #expect(userDefaults.setValueBoolForKeyDefaultNameStringVoidCallsCount == 1)
        #expect(userDefaults.setValueBoolForKeyDefaultNameStringVoidReceivedArguments?.value == true)
        #expect(userDefaults.setValueBoolForKeyDefaultNameStringVoidReceivedArguments?.defaultName == "Hero-1-Liked")
    }

    @Test("When created middleware receives 'load' action, it retrieves the liked state")
    func retrieveLikeState() async {
        // Given
        let userDefaults = PersistentStoreProtocolMock()
        userDefaults.boolForKeyDefaultNameStringBoolReturnValue = true
        let sut = MakeHeroLikeMiddleware(userDefaults: userDefaults)
        let middleware = sut()
        let heroId = 1
        let state = HeroDetailFeature.State(liked: false, selectedHeroId: heroId)

        // When
        let followUp = await middleware(.load, state)

        // Then
        #expect(userDefaults.boolForKeyDefaultNameStringBoolCallsCount == 1)
        #expect(userDefaults.boolForKeyDefaultNameStringBoolReceivedDefaultName == "Hero-1-Liked")
        #expect(followUp == .liked(true))
    }

    @Test("When created middleware receives an unrelated action, it does nothing")
    func unrelatedAction() async {
        // Given
        let userDefaults = PersistentStoreProtocolMock()
        let sut = MakeHeroLikeMiddleware(userDefaults: userDefaults)
        let middleware = sut()
        let heroId = 1
        let state = HeroDetailFeature.State(liked: false, selectedHeroId: heroId)

        // When
        let followUp = await middleware(.dismiss, state)

        // Then
        #expect(userDefaults.setValueBoolForKeyDefaultNameStringVoidCallsCount == 0)
        #expect(userDefaults.boolForKeyDefaultNameStringBoolCallsCount == 0)
        #expect(followUp == nil)
    }
}
