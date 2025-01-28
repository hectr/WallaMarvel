import Testing
@testable import LeanRedux

@MainActor @Suite
struct StoreTests
{
    @Test("Test store initialization with a default state")
    func storeInitialization() throws
    {
        // Given, When
        let store = Store<SampleAction, SampleState>.make(
            middlewares: [],
            reducer: sampleReducer
        )

        // Then
        #expect(store.state.value == SampleState().value, "Initial state value should have default value")
        #expect(store.state.lastMessage == SampleState().lastMessage, "Initial state should have default lastMessage")
    }
    
    @Test("Test that dispatching an action updates the store's state via the reducer")
    func dispatchActionUpdatesState() async
    {
        // Given
        let store = Store<SampleAction, SampleState>.make(
            middlewares: [],
            reducer: sampleReducer
        )
        
        // When
        store.dispatch(.increment)
        
        // Then
        #expect(store.state.value == 1, "Value should have incremented by 1")
        #expect(store.state.lastMessage == "", "No change to lastMessage expected")
    }
    
    @Test("Test that multiple actions update the state correctly")
    func multipleActions() async throws
    {
        // Given
        let store = Store<SampleAction, SampleState>.make(
            middlewares: [],
            reducer: sampleReducer
        )

        // When: Dispatch increment
        store.dispatch(.increment)
        try #require(store.state.value == 1)

        // When: Dispatch custom
        store.dispatch(.custom("Hello Redux"))
        try #require(store.state.value == 1)
        try #require(store.state.lastMessage == "Hello Redux")

        // When: Dispatch decrement
        store.dispatch(.decrement)

        // Then
        #expect(store.state.value == 0)
        #expect(store.state.lastMessage == "Hello Redux")
    }
    
    @Test("Test that middleware is invoked and can produce new actions")
    func middlewareInvokesNewAction() async
    {
        // Given
        let store = Store<SampleAction, SampleState>.make(
            middlewares: [
                customMiddleware,     // triggers a ".custom" action when .increment is received
                sideEffectMiddleware, // no additional action, just a side effect
            ],
            reducer: sampleReducer
        )
        
        // When
        store.dispatch(.increment)

        // Then
        // 1) The original .increment should increment the store's value from 0 to 1
        // 2) The "customMiddleware" should produce a .custom action with "Increment triggered"
        // 3) The store should dispatch that new action and update lastMessage
        #expect(store.state.value == 1, "Value should have incremented by 1")
        Task {
            @MainActor #expect(store.state.lastMessage == "Increment triggered", "Middleware should have triggered a custom message")
        }
    }
    
    @Test("Test that a middleware returning nil does not dispatch a new action")
    func middlewareReturningNil() async
    {
        // Given
        let store = Store<SampleAction, SampleState>.make(
            middlewares: [alwaysNilMiddleware],
            reducer: sampleReducer
        )

        // When
        store.dispatch(.increment)

        // Then
        #expect(store.state.value == 1, "Value should have incremented by 1")
        #expect(store.state.lastMessage == "", "No new action was triggered, so lastMessage remains empty")
    }

    @Test("Test the _noopReducer does not modify the state")
    func noopReducer() throws
    {
        // Given
        let initialState = SampleState(value: 42, lastMessage: "Initial")
        let testAction = SampleAction.increment

        // When
        let resultingState = _noopReducer(action: testAction, state: initialState)

        // Then
        #expect(resultingState == initialState, "_noopReducer should return the same state without modification")
    }
}
