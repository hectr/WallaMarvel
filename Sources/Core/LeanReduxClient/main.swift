import SwiftUI
import LeanRedux

@Feature
actor SampleFeature
{
    struct State: AutoInitiable, DTO
    {
        var name: String?
        var age: Int?
    }

    @Action
    static func load(state: inout State)
    {}

    @Action
    static func loaded(name: String, age: Int?, state: inout State)
    {
        state.name = name
        state.age = age
    }
}

let store = SampleFeature.Store.make(
    middlewares: [],
    reducer: SampleFeature.reduce(currentState:receivedAction:),
    state: SampleFeature.State()
)

store.dispatch(.load)
store.dispatch(.loaded(name: "John", age: 67))

print(store)

guard store.state.name == "John" && store.state.age == 67 else {
    fatalError("Unexpected state")
}

