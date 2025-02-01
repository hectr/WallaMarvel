import SwiftDiagnostics

struct MacroExpansionError: Error, Sendable, CustomStringConvertible
{
    var description: String

    init(_ message: String)
    {
        self.description = message
    }
}
