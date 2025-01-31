@testable import Domain
@testable import DomainTestSupport
@testable import DomainContracts
@testable import DomainContractsTestSupport
import Testing
import Foundation

@Suite
struct GetHeroTests {
    
    @Test("When calling GetHero, it retrieves the correct hero from the repository")
    func getHeroSuccessfully() async {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let getHero = GetHero(repository: repository)
        let heroId = 1
        let characterModel = CharacterModel(
            id: heroId,
            name: "Spider-Man",
            heroDescription: "Peter Parker...",
            thumbnail: URL(string: "http://example.com/image.jpg")
        )
        repository.getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidClosure = { _, completion in
            completion(characterModel)
        }
        
        // When
        let result = await withCheckedContinuation { continuation in
            getHero(heroId: heroId) { hero in
                continuation.resume(returning: hero)
            }
        }
        
        // Then
        #expect(result != nil, "Expected hero to be retrieved, but got nil")
        #expect(result?.id == heroId)
        #expect(result?.name == "Spider-Man")
        #expect(result?.heroDescription == "Peter Parker...")
        #expect(result?.thumbnail?.absoluteString == "http://example.com/image.jpg")
    }
    
    @Test("When calling GetHero with an invalid ID, it returns nil")
    func getHeroNotFound() async {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let getHero = GetHero(repository: repository)
        let heroId = 999 // Non-existent hero ID
        repository.getHeroHeroIdIntCompletionSendableEscapingCharacterModelVoidVoidClosure = { _, completion in
            completion(nil)
        }
        
        // When
        let result = await withCheckedContinuation { continuation in
            getHero(heroId: heroId) { hero in
                continuation.resume(returning: hero)
            }
        }

        // Then
        #expect(result == nil, "Expected nil for non-existent hero, but got \(String(describing: result))")
    }
}
