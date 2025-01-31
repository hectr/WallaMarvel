import SwiftUI
import LeanRedux

struct HeroDetailHeaderView: View
{
    // MARK: Dependencies

    @EnvironmentObject
    private var store: HeroDetailFeature.Store

    @Environment(\.lexemes)
    private var lexemes: Lexemes

    // MARK: Content

    private var viewState: State
    {
        State(state: store.state)
    }

    var body: some View
    {
        HStack {
            dismissButton
            Spacer()
            likeButton
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(.black.opacity(viewState.opacity))
    }

    var dismissButton: some View
    {
        button {
            store.dispatch(.dismiss)
        } label: {
            Label(lexemes.dismiss, systemImage: "chevron.down")
        }
    }

    var likeButton: some View
    {
        let button = button {
            store.dispatch(.like)
        } label: {
            Label(
                viewState.liked ? lexemes.unlikeHero : lexemes.likeHero,
                systemImage: viewState.liked ? "heart.fill" : "heart"
            )
        }
        if #available(iOS 17.0, *) {
            return button.symbolEffect(.bounce, value: viewState.liked)
        } else {
            return button
        }
    }

    func button<Label: View>(
        action: @escaping () -> Void,
        label: () -> Label
    ) -> some View
    {
        Button(
            action: { action() },
            label: label
        )
        .labelStyle(.iconOnly)
        .font(.title)
        .scaledToFit()
        .foregroundColor(.white)
    }
    
    // MARK: View State

    struct State: DTO
    {
        var opacity = 0.14
        var liked: Bool

        init(state: HeroDetailFeature.State)
        {
            self.liked = state.liked
        }
    }
}

// MARK: - Preview

struct HeroDetailHeaderView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HeroDetailHeaderView()
            .environmentObject(
                HeroDetailFeature.Store.make(
                    middlewares: [],
                    reducer: HeroDetailFeature.reduce,
                    state: HeroDetailFeature.State().with(\.liked, true)
                )
            )
    }
}
