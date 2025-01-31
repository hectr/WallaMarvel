import LeanRedux
import Routing
import SwiftUI
import UIKit

/// sourcery: AutoMockable
protocol MakeHeroLikeMiddlewareProtocol
{
    func callAsFunction() -> HeroDetailFeature.Store.Middleware
}

public struct MakeHeroLikeMiddleware: MakeHeroLikeMiddlewareProtocol
{
    // MARK: Dependencies

    private let userDefaults: PersistentStoreProtocol

    // MARK: Lifecycle

    static func make() -> MakeHeroLikeMiddlewareProtocol
    {
        MakeHeroLikeMiddleware(userDefaults: UserDefaults.standard)
    }

    init(userDefaults: PersistentStoreProtocol)
    {
        self.userDefaults = userDefaults
    }

    // MARK: Logic

    func callAsFunction() -> HeroDetailFeature.Store.Middleware
    {
        return { action, state in
            var followUp = HeroDetailFeature.Action?.none
            if action == .like, let heroId = state.selectedHeroId {
                store(heroId: heroId, liked: state.liked)
            } else if action == .load, let heroId = state.selectedHeroId {
                let liked = restore(heroId: heroId)
                followUp = .liked(liked)
            }
            return followUp
        }
    }

    private func store(heroId: Int, liked: Bool)
    {
        let key = Self.userDefaultsKey(for: heroId)
        userDefaults.set(liked, forKey: key)
    }

    private func restore(heroId: Int) -> Bool
    {
        let key = Self.userDefaultsKey(for: heroId)
        return userDefaults.bool(forKey: key)
    }

    private static func userDefaultsKey(for heroId: Int) -> String
    {
        "Hero-\(heroId)-Liked"
    }
}
