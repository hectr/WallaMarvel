@testable import CoreDomain
import CoreDomainContracts
import CoreDomainContractsTestSupport
@testable import CoreDomainTestSupport
import Testing
import Foundation

/// This struct is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
/// 
@Suite @MainActor
struct FetchNextPageTests
{
    @Test("When calling GetHeroes, it retrieves the list of heroes from the repository")
    func sutSuccessfully() async throws {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let sut = FetchNextPage(repository: repository)
        let heroes = [
            CharacterModel(id: 1, name: "Spider-Man", heroDescription: "Peter Parker...", thumbnail: URL(string: "http://example.com/spiderman.jpg")),
            CharacterModel(id: 2, name: "Iron Man", heroDescription: "Tony Stark...", thumbnail: URL(string: "http://example.com/ironman.jpg"))
        ]
        let characterContainer = CharacterModelContainer(count: 2, limit: 10, offset: 0, results: heroes)
        repository.fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure = { onSuccess, onFailure in
            onSuccess([characterContainer])
        }

        // When
        let result = try await withCheckedThrowingContinuation { continuation in
            sut(
                onSuccess: { container in continuation.resume(returning: container) },
                onFailure: { error in continuation.resume(throwing: error) }
            )
        }
        
        // Then
        #expect(result.count == 1)
        #expect(result[0].count == 2)
        #expect(result[0].results.count == 2)
        #expect(result[0].results[0].name == "Spider-Man")
        #expect(result[0].results[1].name == "Iron Man")
        #expect(result[0].results[0].thumbnail?.absoluteString == "http://example.com/spiderman.jpg")
        #expect(result[0].results[1].thumbnail?.absoluteString == "http://example.com/ironman.jpg")
    }
    
    @Test("When calling GetHeroes and no heroes are found, it returns an empty list")
    func sutEmptyList() async throws {
        // Given
        let repository = MarvelRepositoryProtocolMock()
        let sut = FetchNextPage(repository: repository)
        let characterContainer = CharacterModelContainer(count: 0, limit: 10, offset: 0, results: [])
        repository.fetchHeroesOnSuccessSendableEscapingCharacterModelContainerVoidOnFailureSendableEscapingErrorVoidVoidClosure = { onSuccess, onFailure in
            onSuccess([characterContainer])
        }
        
        // When
        let result = try await withCheckedThrowingContinuation { continuation in
            sut(
                onSuccess: { container in continuation.resume(returning: container) },
                onFailure: { error in continuation.resume(throwing: error) }
            )
        }
        
        // Then
        #expect(result.count == 1)
        #expect(result.count == 1)
        #expect(result[0].results.isEmpty)
    }
}
