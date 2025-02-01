import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(LeanReduxMacros)
import LeanReduxMacros

let testMacros: [String: Macro.Type] = [
    "Action": ActionMacro.self,
    "Feature": FeatureMacro.self,
]
#endif

final class LeanReduxMacrosTests: XCTestCase {
    func test() throws {
        #if canImport(LeanReduxMacros)
        assertMacroExpansion(
            """
            @Feature
            struct SampleFeature {
                struct State: AutoInitiable, DTO {
                    var name: String?
                    var age: Int?
                }

                @Action
                static func load(completion: @escaping @Sendable (Error?) -> Void, state: inout State) {}

                @Action
                static func loaded(name: String, age: Int?, state: inout State) {
                    state.name = name
                    state.age = age
                }
                
                @Action
                static func exit(state: inout State) {}
            }
            """,
            expandedSource: """
            struct SampleFeature {
                struct State: AutoInitiable, DTO {
                    var name: String?
                    var age: Int?
                }
                static func load(completion: @escaping @Sendable (Error?) -> Void, state: inout State) {}
                static func loaded(name: String, age: Int?, state: inout State) {
                    state.name = name
                    state.age = age
                }

                static func exit(state: inout State) {}

                enum Action: DTO {
                    case load(completion:   @Sendable (Error?) -> Void)
                    case loaded(name: String, age: Int?)
                    case exit
                }

                typealias Store = LeanRedux.Store<Action, State>

                static func reduce(currentState: State, receivedAction: Action) -> State {
                    var newState = currentState
                    switch receivedAction {
                    case .load(let completion):
                        load(completion: completion, state: &newState)
                    case .loaded(let name, let age):
                        loaded(name: name, age: age, state: &newState)
                    case .exit:
                        exit(state: &newState)
                    }
                    return newState
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
