
@attached(peer)  // Does not generate new members, it's just a marker
public macro Action() = #externalMacro(
    module: "LeanReduxMacros",
    type: "ActionMacro"
)

@attached(member, names: named(Action), named(Store), named(reduce))
public macro Feature() = #externalMacro(
    module: "LeanReduxMacros",
    type: "FeatureMacro"
)
