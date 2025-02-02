import CoreDomainContracts
import Foundation

/// This protocol is @MainActor-isolated because of a Swift bug. See `MarvelRepository` for more details.
///
/// sourcery: AutoMockable
@MainActor
public protocol MarvelRepositoryProtocol
{
    func fetchHeroes(
        onSuccess: @escaping @Sendable ([CharacterModelContainer]) -> Void,
        onFailure: @escaping @Sendable (Error)-> Void
    )

    func getHero(
        heroId: Int,
        completion: @escaping @Sendable (CharacterModel?) -> Void
    )
}

enum MarvelRepositoryError: Error
{
    case alreadyFetching(offset: Int)
}

/// This class is @MainActor-isolated because of a Swift bug.
/// The bug will be fixed in Swift 6.1: https://github.com/swiftlang/swift/commit/f0fff2e5a02d8f56fc272ed0562a888d10f17f9b
///
@MainActor
public final class MarvelRepository: MarvelRepositoryProtocol
{
    // MARK: Dependencies

    private let local: CharacterModelContainerStoreProtocol
    private let remote: MarvelRemoteDataSourceProtocol

    // MARK: Lifecycle

    public static func make() -> MarvelRepositoryProtocol
    {
        MarvelRepository(
            local: CharacterModelContainerStore.make(),
            remote: MarvelRemoteDataSource.make()
        )
    }

    init(
        local: CharacterModelContainerStoreProtocol,
        remote: MarvelRemoteDataSourceProtocol
    )
    {
        self.local = local
        self.remote = remote
    }

    // MARK: Logic

    public func fetchHeroes(
        onSuccess: @escaping @Sendable ([CharacterModelContainer]) -> Void,
        onFailure: @escaping @Sendable (Error)-> Void
    )
    {
        Task {
            let lastPage = await local.pages.last
            let offset = await local.nextOffset

            try await self.lockOffset(offset)

            remote.fetchHeroes(
                limit: lastPage?.limit,
                offset: offset,
                onSuccess: { [local] dataModel in
                    let model = CharacterModelContainer(dataModel)
                    Task { @Background in
                        local.add(page: model)
                        onSuccess(local.pages)
                    }
                },
                onFailure: { error in
                    Task {
                        await self.unlockOffset(offset)
                    }
                    onFailure(error)
                }
            )
        }
    }

    public func getHero(heroId: Int, completion: @escaping @Sendable (CharacterModel?) -> Void)
    {
        Task { @Background in
            let hero = local.get(hero: heroId)
            completion(hero)
        }
    }

    @Background
    private func lockOffset(_ offset: Int) throws  {
        guard !local.lockedOffsets.contains(offset) else {
            throw MarvelRepositoryError.alreadyFetching(offset: offset)
        }
        local.lockedOffsets.append(offset)
    }

    @Background
    private func unlockOffset(_ offset: Int) {
        guard let index = local.lockedOffsets.firstIndex(of: offset) else {
            assertionFailure("offset \(offset) not found in requestedOffsets")
            return
        }
        local.lockedOffsets.remove(at: index)
    }
}
