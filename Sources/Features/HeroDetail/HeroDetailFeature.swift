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
    {
        // TODO: implement
#if DEBUG
        state.name = "3-D Man"
        state.heroDescription = """
        The 3-D Man was a 1950's hero who came about through the unique merger of two brothers, Hal and Chuck Chandler. Chuck was a test pilot who was abducted by alien Skrulls during an important test flight. Earth was seen as a strategic location in the ongoing conflict between the alien Kree and Skrull Empires, so the Skrulls were seeking information on Earth's space program and had captured Chuck to interrogate him. Chuck resisted and escaped, accidentally causing the explosion of the Skrull spacecraft in the process. While his brother Hal watched, the radiation from the explosion seemingly disintegrated Chuck, who disappeared in a burst of light. Hal later discovered, however, that the light burst had imprinted an image of Chuck on each lens of Hal's eyeglasses. Through concentration, Hal could merge the images and cause Chuck to reappear as a three-dimensional man. Chuck become the costumed adventurer known as the 3-D Man and single-handedly subverted the Skrulls' early attempts to undermine Earthly civilization.
        """
        state.thumbnail = URL(string: "https://cdn.marvel.com/content/1x/3dman442.jpg")
#else
        fatalError("not implemented yet")
#endif
    }

    static func toggleDescription(state: inout State)
    {
        state.isDescriptionExpanded.toggle()
    }
}
