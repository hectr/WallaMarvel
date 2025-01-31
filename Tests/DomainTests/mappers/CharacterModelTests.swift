@testable import DataContracts
@testable import Domain
@testable import DomainContracts
import Testing
import Foundation

@Suite
struct CharacterModelTests
{
    @Test("When mapping CharacterDataModel to CharacterModel, it correctly converts values")
    func fromDataModel()
    {
        // Given
        let thumbnail = Thumbnail(path: "http://example.com/image", extension: "jpg")
        let dataModel = CharacterDataModel(id: 1, name: "Spider-Man", thumbnail: thumbnail)

        // When
        let model = CharacterModel(dataModel)

        // Then
        #expect(model.id == 1)
        #expect(model.name == "Spider-Man")
        #expect(model.thumbnail?.absoluteString == "http://example.com/image/portrait_small.jpg")
    }
}
