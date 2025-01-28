import SwiftUI

final class Lexemes: ObservableObject
{
    let likeHero: LocalizedStringKey = "Like"
    let unlikeHero: LocalizedStringKey = "Unlike"
    let dismiss: LocalizedStringKey = "Dismiss"
    let showMore: LocalizedStringKey = "Show More"
    let showLess: LocalizedStringKey = "Show Less"
}

// MARK: - Environment

struct LexemesEnvironmentKey: EnvironmentKey
{
    static var defaultValue: Lexemes
    {
        Lexemes()
    }
}

extension EnvironmentValues
{
    var lexemes: Lexemes
    {
        get { self[LexemesEnvironmentKey.self] }
        set { self[LexemesEnvironmentKey.self] = newValue }
    }
}

// MARK: - View Modifier

extension View
{
    func lexemes(_ value: Lexemes) -> some View
    {
        environment(\.lexemes, value)
    }
}
