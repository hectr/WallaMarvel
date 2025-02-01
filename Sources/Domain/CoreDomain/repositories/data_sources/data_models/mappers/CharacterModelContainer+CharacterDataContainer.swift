import CoreDomainContracts

extension CharacterModelContainer
{
    init(_ data: CharacterDataContainer)
    {
        self.init(
            count: data.data.count,
            limit: data.data.limit,
            offset: data.data.offset,
            results: data.data.results.map(CharacterModel.init(_:))
        )
    }
}
