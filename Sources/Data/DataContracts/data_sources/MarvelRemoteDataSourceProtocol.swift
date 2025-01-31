/// sourcery: AutoMockable
public protocol MarvelRemoteDataSourceProtocol
{
    func fetchHeroes(completion: @escaping @Sendable (CharacterDataContainer) -> Void)
}
