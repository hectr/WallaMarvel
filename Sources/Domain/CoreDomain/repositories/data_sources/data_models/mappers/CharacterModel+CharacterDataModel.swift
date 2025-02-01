import CoreDomainContracts
import Foundation

extension CharacterModel
{
    init(_ data: CharacterDataModel)
    {
        self.init(
            id: data.id,
            name: data.name,
            heroDescription: data.description,
            thumbnail: URL(data.thumbnail)
        )
    }
}
