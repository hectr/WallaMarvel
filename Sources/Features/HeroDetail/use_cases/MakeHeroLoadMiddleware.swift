import CoreDomainContracts
import LeanRedux
import Routing
import SwiftUI
import UIKit

/// sourcery: AutoMockable
protocol MakeHeroLoadMiddlewareProtocol
{
    func callAsFunction() -> HeroDetailFeature.Store.Middleware
}

public struct MakeHeroLoadMiddleware: MakeHeroLoadMiddlewareProtocol
{
    // MARK: Dependencies

    private let getHero: GetHeroProtocol

    // MARK: Lifecycle

    static func make(getHero: GetHeroProtocol) -> MakeHeroLoadMiddlewareProtocol
    {
        MakeHeroLoadMiddleware(getHero: getHero)
    }

    init(getHero: GetHeroProtocol)
    {
        self.getHero = getHero
    }

    // MARK: Logic

    func callAsFunction() -> HeroDetailFeature.Store.Middleware
    {
        return { action, state in
            var followUp = HeroDetailFeature.Action?.none
            if action == .load, let heroId = state.selectedHeroId
            {
                followUp = await withCheckedContinuation { continuation in
                    getHero(heroId: heroId) { characterModel in
                        if let characterModel {
                            continuation.resume(
                                returning: .loaded(
                                    name: characterModel.name,
                                    description: characterModel.heroDescription,
                                    thumbnail: characterModel.thumbnail
                                )
                            )
                        } else {
                            continuation.resume(returning: nil)
                        }
                    }
                }
            }
            return followUp
        }
    }
}
