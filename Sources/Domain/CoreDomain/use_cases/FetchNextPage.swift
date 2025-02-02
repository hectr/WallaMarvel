import CoreDomainContracts

@MainActor
public struct FetchNextPage: FetchNextPageProtocol
{
    // MARK: Dependencies

    private let repository: MarvelRepositoryProtocol

    // MARK: Lifecycle

    public static func make(repository: MarvelRepositoryProtocol) -> FetchNextPageProtocol
    {
        FetchNextPage(repository: repository)
    }

    init(repository: MarvelRepositoryProtocol)
    {
        self.repository = repository
    }

    // MARK: Logic

    public func callAsFunction(
        onSuccess: @escaping @Sendable (_ allPages: [CharacterModelContainer]) -> Void,
        onFailure: @escaping @Sendable (_ error: Error) -> Void
    )
    {
        repository.fetchHeroes(
            onSuccess: { containers in onSuccess(containers) },
            onFailure: { error in onFailure(error) }
        )
    }
}
