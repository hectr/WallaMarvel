import SwiftUI

/**
 Keeps the centralized state of a view (or views) and publishes a new state when an action is dispatched.

 ```
                                      4. new STATE                     6. (optional) new ACTION
          ┌────────────────────────────────────────┐   ┌────────────────────────────────────────┐
          │                                        │   │                                        │
          ▽                                        │   ▽                                        │
  ┌───────────────┐  1. user ACTION          ┌─────┴─────────┐   5. new STATE + ACTION  ┌───────┴───────┐
  │      VIEW     ├─────────────────────────▷│     STORE     ├─────────────────────────▷│ MIDDLEWARE(S) ├─┐
  └───────────────┘                          └─────┬─────────┘                          └─┬─────────────┘ ├─┐
                                                   │    △                                 └─┬─────────────┘ ├─┐
                         2. current STATE + ACTION │    │ 3. new STATE                      └─┬─────────────┘ │
                                                   ▽    │                                     └───────────────┘
                                             ┌──────────┴────┐
                                             │    REDUCER    │
                                             └───────────────┘
 ```
 */
public final class Store<Action: DTO, State: AutoInitiable & DTO>: ObservableObject
{
    /// Middlewares act like interceptors for actions dispatched to the store.
    /// When an action is dispatched, it first passes through the reducer and then through all the registered middlewares in the order they were added to the store.
    public typealias Middleware = (
        _ action: Action,
        _ associatedState: State
    ) async -> Action?

    /// A pure function that takes the current state and an action, and returns a new state.
    /// Reducers are responsible for updating the state based on the actions that are dispatched.
    public typealias Reducer = (
        _ currentState: State,
        _ receivedAction: Action
    ) -> State

    /// State is immutable from the outside of the `Store`.
    /// State can be set only by dispatching an `Action` to `Store`.
    @Published
    public private(set) var state: State

    /// Each middleware has access to the action and the current state, allowing them to perform any tasks and returning an optional action.
    private let middlewares: [Middleware]

    /// Computes the new state resulting from an action.
    private let reducer: Reducer

    /// Factory method that produces a `Store` with a default `State`.
    public static func make(
        middlewares: [Middleware],
        reducer: @escaping Reducer
    ) -> Store<Action, State>
    {
        Store(
            middlewares: middlewares,
            reducer: reducer,
            state: State()
        )
    }

    /// Initializer used internally by `make(middlewares:reducer:)`.
    init(
        middlewares: [Middleware],
        reducer: @escaping Reducer,
        state: State
    ) {
        self.middlewares = middlewares
        self.reducer = reducer
        self.state = state
    }

    /// Forwards an action to the reducer and the middlewares.
    public func dispatch(_ action: Action) async
    {
        state = reducer(
            state,
            action
        )
        
        var newActions = [Action?]()
        for middleware in middlewares {
            let newAction = await middleware(
                action,
                state
            )
            newActions.append(newAction)
        }

        await dispatch(newActions)
    }


    /// Unwraps and dispatches received actions.
    /// Used internally by `dispatch(_:)`.
    private func dispatch(_ candidates: [Action?]) async
    {
        let actions = candidates.compactMap { action in action }
        for action in actions {
            await dispatch(action)
        }
    }
}

#if DEBUG
/// No-op / identity reducer.
/// Only for debugging, testing and previews.
func _noopReducer<Action: DTO, State: DTO>(
    action _: Action,
    state: State
) -> State
{
    state
}
#endif
