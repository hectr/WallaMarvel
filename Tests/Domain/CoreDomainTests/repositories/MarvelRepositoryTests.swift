@testable import CoreDomain
import CoreDomainContracts
import CoreDomainContractsTestSupport
@testable import CoreDomainTestSupport
import Testing
import Foundation

@Suite
struct MarvelRepositoryTests {
    
    @Test("When fetching heroes, it retrieves data from remote and stores it locally")
    func fetchHeroesSuccessfully() async {
        // Given
        let localStore = await CharacterModelContainerStoreProtocolMock()
        let remote = MarvelRemoteDataSourceProtocolMock()
        let repository = MarvelRepository(local: localStore, remote: remote)
        let characterDataContainer = CharacterDataContainer(
            data: CharacterDataContainer.CharacterData(
                count: 1,
                limit: 10,
                offset: 0,
                results: [
                    CharacterDataModel(
                        id: 1,
                        name: "Spider-Man",
                        description: "Peter Parker...",
                        thumbnail: Thumbnail(path: "http://example.com/image", extension: "jpg")
                    )
                ]
            )
        )
        remote.fetchHeroesCompletionSendableEscapingCharacterDataContainerVoidVoidClosure = { completion in
            completion(characterDataContainer)
        }
        
        // When
        let result = await withCheckedContinuation { continuation in
            repository.fetchHeroes { container in
                continuation.resume(returning: container)
            }
        }
        
        // Then
        #expect(result.count == 1)
        #expect(result.results.first?.id == 1)
        #expect(result.results.first?.name == "Spider-Man")
        #expect(result.results.first?.thumbnail?.absoluteString == "http://example.com/image/portrait_small.jpg")
        #expect(await localStore.addPageCharacterModelContainerVoidCallsCount == 1)
    }
    
    @Test("When retrieving a hero by ID, it fetches from local storage")
    func getHeroSuccessfully() async {
        // Given
        let localStore = await CharacterModelContainerStoreProtocolMock()
        let remote = MarvelRemoteDataSourceProtocolMock()
        let repository = MarvelRepository(local: localStore, remote: remote)
        let heroId = 1
        let characterModel = CharacterModel(
            id: heroId,
            name: "Spider-Man",
            heroDescription: "Peter Parker...",
            thumbnail: URL(string: "http://example.com/image.jpg")
        )
        _ = await Task { @Background in
            localStore.getHeroIdIntCharacterModelReturnValue = characterModel
        }.value

        // When
        let result = await withCheckedContinuation { continuation in
            repository.getHero(heroId: heroId) { hero in
                continuation.resume(returning: hero)
            }
        }
        
        // Then
        #expect(result != nil, "Expected hero to be retrieved, but got nil")
        #expect(result?.id == heroId)
        #expect(result?.name == "Spider-Man")
        #expect(result?.thumbnail?.absoluteString == "http://example.com/image.jpg")
    }
}
