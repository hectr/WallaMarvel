@testable import Domain
@testable import DomainTestSupport
@testable import DomainContracts
@testable import DomainContractsTestSupport
import Testing
import Foundation

@Suite
struct GetHeroesTests {
    
    @Test("When calling GetHeroes, it retrieves the list of heroes from the repository")
    func getHeroesSuccessfully() async {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let getHeroes = GetHeroes(repository: repository)
        let heroes = [
            CharacterModel(id: 1, name: "Spider-Man", heroDescription: "Peter Parker...", thumbnail: URL(string: "http://example.com/spiderman.jpg")),
            CharacterModel(id: 2, name: "Iron Man", heroDescription: "Tony Stark...", thumbnail: URL(string: "http://example.com/ironman.jpg"))
        ]
        let characterContainer = CharacterModelContainer(count: 2, limit: 10, offset: 0, results: heroes)
        repository.fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidClosure = { completion in
            completion(characterContainer)
        }
        
        // When
        let result = await withCheckedContinuation { continuation in
            getHeroes { container in
                continuation.resume(returning: container)
            }
        }
        
        // Then
        #expect(result.count == 2)
        #expect(result.results.count == 2)
        #expect(result.results[0].name == "Spider-Man")
        #expect(result.results[1].name == "Iron Man")
        #expect(result.results[0].thumbnail?.absoluteString == "http://example.com/spiderman.jpg")
        #expect(result.results[1].thumbnail?.absoluteString == "http://example.com/ironman.jpg")
    }
    
    @Test("When calling GetHeroes and no heroes are found, it returns an empty list")
    func getHeroesEmptyList() async {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let getHeroes = GetHeroes(repository: repository)
        let characterContainer = CharacterModelContainer(count: 0, limit: 10, offset: 0, results: [])
        repository.fetchHeroesCompletionSendableEscapingCharacterModelContainerVoidVoidClosure = { completion in
            completion(characterContainer)
        }
        
        // When
        let result = await withCheckedContinuation { continuation in
            getHeroes { container in
                continuation.resume(returning: container)
            }
        }
        
        // Then
        #expect(result.count == 0)
        #expect(result.results.isEmpty)
    }
}
