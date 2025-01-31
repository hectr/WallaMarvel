@testable import DomainContracts
@testable import DomainContractsTestSupport
@testable import HeroDetail
@testable import HeroDetailTestSupport
import Testing
import Foundation

@Suite
struct MakeHeroLoadMiddlewareTests
{
    @Test("When created middleware receives 'load' action, it fetches hero data and returns 'loaded' action")
    func loadHeroSuccessfully() async {
        // Given
        let getHero = GetHeroProtocolMock()
        let middleware = MakeHeroLoadMiddleware(getHero: getHero)()
        let heroId = 1
        let state = HeroDetailFeature.State(selectedHeroId: heroId)
        let characterModel = CharacterModel(
            id: heroId,
            name: "Spider-Man",
            heroDescription: "Peter Parker...",
            thumbnail: URL(string: "http://example.com/image.jpg")
        )
        getHero.callAsFunctionClosure = { _, completion in
            completion(characterModel)
        }
        
        // When
        let followUp = await middleware(.load, state)
        
        // Then
        #expect(
            followUp == .loaded(
                name: "Spider-Man",
                description: "Peter Parker...",
                thumbnail: URL(string: "http://example.com/image.jpg"))
        )
    }

    @Test("When created middleware receives 'load' action and hero is not found, it returns nil")
    func loadHeroNotFound() async {
        // Given
        let getHero = GetHeroProtocolMock()
        let middleware = MakeHeroLoadMiddleware(getHero: getHero)()
        let heroId = 1
        let state = HeroDetailFeature.State(selectedHeroId: heroId)
        getHero.callAsFunctionClosure = { _, completion in
            completion(nil)
        }
        
        // When
        let followUp = await middleware(.load, state)
        
        // Then
        #expect(followUp == nil)
    }
}
