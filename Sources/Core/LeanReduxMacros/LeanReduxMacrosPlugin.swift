import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct LeanReduxMacrosPlugin: CompilerPlugin
{
    let providingMacros: [Macro.Type] = [
        ActionMacro.self,
        FeatureMacro.self,
    ]
}
