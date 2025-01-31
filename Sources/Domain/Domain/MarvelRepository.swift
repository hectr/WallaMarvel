import DataContracts

public protocol MarvelRepositoryProtocol {
    func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void)
}

public final class MarvelRepository: MarvelRepositoryProtocol
{
    // MARK: Dependencies

    private let dataSource: MarvelDataSourceProtocol

    // MARK: Lifecycle

    public static func make(dataSource: MarvelDataSourceProtocol) -> MarvelRepositoryProtocol
    {
        MarvelRepository(dataSource: dataSource)
    }

    init(dataSource: MarvelDataSourceProtocol)
    {
        self.dataSource = dataSource
    }

    // MARK: Logic

    public func getHeroes(completionBlock: @escaping @Sendable (CharacterDataContainer) -> Void)
    {
        dataSource.getHeroes(completionBlock: completionBlock)
    }
}
