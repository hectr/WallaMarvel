import LeanRedux

/// Sample actions.
enum SampleAction: DTO
{
    case increment
    case decrement
    case custom(String)
}

/// Sample state.
struct SampleState: AutoInitiable, DTO
{
    static let defaultValue = 0
    static let defaultLastMessage = ""
    
    var value = Self.defaultValue
    var lastMessage = Self.defaultLastMessage
}

/// Sample reducer.
func sampleReducer(currentState: SampleState, receivedAction: SampleAction) -> SampleState
{
    var newState = currentState
    switch receivedAction {
    case .increment:
        newState.value += 1
    case .decrement:
        newState.value -= 1
    case .custom(let message):
        newState.lastMessage = message
    }
    return newState
}

/// Sample middleware returning a new action.
func customMiddleware(action: SampleAction, state: SampleState) async -> SampleAction?
{
    switch action {
    // If user increments, automatically trigger a .custom action
    case .increment:
        return .custom("Increment triggered")
    default:
        return nil
    }
}

/// Sample middleware that modifies state externally or logs side effects.
func sideEffectMiddleware(action: SampleAction, state: SampleState) async -> SampleAction?
{
    // Just to illustrate an async context or side effect, e.g. logging
    await Task.yield()
    return nil
}

/// A middleware that always returns `nil`.
let alwaysNilMiddleware: Store<SampleAction, SampleState>.Middleware = { action, state in
    return nil
}
