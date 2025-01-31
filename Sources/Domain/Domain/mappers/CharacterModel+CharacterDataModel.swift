import DataContracts
import DomainContracts
import Foundation

extension CharacterModel
{
    public init(_ data: CharacterDataModel)
    {
        self.init(
            id: data.id,
            name: data.name,
            heroDescription: data.description,
            thumbnail: URL(data.thumbnail)
        )
    }
}
