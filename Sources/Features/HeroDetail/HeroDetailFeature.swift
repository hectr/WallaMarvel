import SwiftUI
import LeanRedux

@Feature
enum HeroDetailFeature
{
    struct State: AutoInitiable, DTO
    {
        var heroDescription = String()
        var isDescriptionExpanded = Bool()
        var liked = Bool()
        var name = String()
        var selectedHeroId = Int?.none
        var thumbnail = URL?.none
    }

    @Action
    static func dismiss(state: inout State)
    {}

    @Action
    static func like(state: inout State)
    {
        state.liked.toggle()
    }

    @Action
    static func liked(flag: Bool, state: inout State)
    {
        state.liked = flag
    }

    @Action
    static func load(state: inout State)
    {}

    @Action
    static func loaded(name: String, description: String, thumbnail: URL?, state: inout State)
    {
        state.name = name
        state.heroDescription = description
        state.thumbnail = thumbnail
    }

    @Action
    static func toggleDescription(state: inout State)
    {
        state.isDescriptionExpanded.toggle()
    }
}
