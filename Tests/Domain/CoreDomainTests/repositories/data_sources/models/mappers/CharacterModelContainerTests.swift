@testable import CoreDomain
import CoreDomainContracts
import Testing
import Foundation

@Suite
struct CharacterModelContainerTests
{
    @Test("When mapping CharacterDataContainer to CharacterModelContainer, it correctly converts values")
    func fromDataModel()
    {
        // Given
        let thumbnail = Thumbnail(path: "http://example.com/image", extension: "jpg")
        let characterDataModel = CharacterDataModel(
            id: 1,
            name: "Spider-Man",
            description: "Peter Parker alter ego.",
            thumbnail: thumbnail
        )
        let characterData = CharacterDataContainer.CharacterData(count: 1, limit: 10, offset: 0, results: [characterDataModel])
        let dataContainer = CharacterDataContainer(data: characterData)
        
        // When
        let modelContainer = CharacterModelContainer(dataContainer)
        
        // Then
        #expect(modelContainer.count == 1)
        #expect(modelContainer.limit == 10)
        #expect(modelContainer.offset == 0)
        #expect(modelContainer.results.count == 1)
        #expect(modelContainer.results.first?.id == 1)
        #expect(modelContainer.results.first?.name == "Spider-Man")
        #expect(modelContainer.results.first?.thumbnail?.absoluteString == "http://example.com/image/portrait_small.jpg")
    }
}
