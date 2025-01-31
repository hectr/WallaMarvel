public protocol MarvelDataSourceProtocol
{
    func getHeroes(
        completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void
    )
}
