import SwiftUI
import LeanRedux

struct HeroDetailFeature
{
    enum Action: DTO
    {
        case dismiss
        case like
        case liked(Bool)
        case load
        case loaded(name: String, description: String, thumbnail: URL?)
        case toggleDescription
    }

    struct State: AutoInitiable, DTO
    {
        var heroDescription = String()
        var isDescriptionExpanded = Bool()
        var liked = Bool()
        var name = String()
        var selectedHeroId = Int?.none
        var thumbnail = URL?.none
    }

    typealias Store = LeanRedux.Store<Action, State>

    static func reduce(currentState: State, receivedAction: Action) -> State
    {
        var newState = currentState
        switch receivedAction {
        case .dismiss:
            break

        case .like:
            like(state: &newState)

        case .liked(let flag):
            liked(flag: flag, state: &newState)

        case .load:
            load(state: &newState)

        case .loaded(let name, let description, let thumbnail):
            loaded(name: name, description: description, thumbnail: thumbnail, state: &newState)

        case .toggleDescription:
            toggleDescription(state: &newState)
        }
        return newState
    }

    static func like(state: inout State)
    {
        state.liked.toggle()
    }

    static func liked(flag: Bool, state: inout State)
    {
        state.liked = flag
    }

    static func load(state: inout State)
    {}

    static func loaded(name: String, description: String, thumbnail: URL?, state: inout State)
    {
        state.name = name
        state.heroDescription = description
        state.thumbnail = thumbnail
    }

    static func toggleDescription(state: inout State)
    {
        state.isDescriptionExpanded.toggle()
    }
}
