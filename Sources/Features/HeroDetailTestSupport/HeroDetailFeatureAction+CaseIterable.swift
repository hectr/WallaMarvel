import Foundation
@testable import HeroDetail

extension HeroDetailFeature.Action: CaseIterable
{
    public static var allCases: [HeroDetailFeature.Action]
    {[
        .dismiss,
        .like,
        .liked(false),
        .liked(true),
        .load,
        .loaded(name: String(), description: String(), thumbnail: URL?.none),
        .toggleDescription
    ]}
}
