import SwiftUI

// Source: https://www.swiftjectivec.com/swiftui-run-code-only-once-versus-onappear-or-task/

extension View
{
    /// Executes a synchronous action the first time the view appears.
    public func onFirstAppear(_ action: @escaping () async -> ()) -> some View
    {
        modifier(FirstAppear(action: .async(action)))
    }

    /// Executes an asynchronous action the first time the view appears.
    public func onFirstAppear(_ action: @escaping () -> ()) -> some View
    {
        modifier(FirstAppear(action: .sync(action)))
    }
}

/// Executes an action only once when a view first appears.
private struct FirstAppear: ViewModifier
{
    enum Action
    {
        case async(_ action: () async -> ())
        case sync(_ action: () -> ())
    }

    let action: Action

    // Use this to only fire your block one time
    @State private var hasAppeared = false

    func body(content: Content) -> some View
    {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            switch action {
                case .async(let action):
                Task {
                    await action()
                }
            case .sync(let action):
                action()
            }
        }
    }
}

struct FirstAppear_Previews: PreviewProvider {
    struct OnFirstAppearCounterView: View {
        @State var appearances = 0

        var body: some View {
            Text("onFirstAppear calls count = \(appearances)")
                .onFirstAppear {
                    appearances += 1
                }
        }
    }

    static var previews: some View {
        OnFirstAppearCounterView()
    }
}
