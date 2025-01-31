import Kingfisher
import LeanRedux
import SwiftUI

struct HeroDetailView: View
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
        ZStack{
            HeroDetailBackgroundView()
            VStack{
                HeroDetailHeaderView()
                ScrollView {
                    KFImage(viewState.imageUrl)
                        .placeholder(RemoteImagePlaceholderView.init(progress:))
                        .fade(duration: CATransaction.animationDuration())
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding()
                    Divider()
                        .background(.white)
                        .padding(.vertical)
                    HeroDetailInfoView()
                    Spacer()
                }
            }
        }
        .onFirstAppear {
            store.dispatch(.load)
        }
    }

    // MARK: Lifecycle

    static func make(
        heroId: Int,
        middlewares: [HeroDetailFeature.Store.Middleware]
    ) -> some View
    {
        HeroDetailView()
            .environmentObject(
                HeroDetailFeature.Store.make(
                    middlewares: middlewares,
                    reducer: HeroDetailFeature.reduce,
                    state: HeroDetailFeature.State().with(\.selectedHeroId, heroId)
                )
            )
    }

    // MARK: View State

    struct State: DTO
    {
        var imageUrl: URL?
        var isDescriptionExpanded: Bool

        init(state: HeroDetailFeature.State)
        {
            self.imageUrl = state.thumbnail
            self.isDescriptionExpanded = state.isDescriptionExpanded
        }
    }
}

// MARK: - Preview

let state = HeroDetailFeature.State()
    .with(\.name, "3-D Man")
    .with(\.heroDescription, """
    The 3-D Man was a 1950's hero who came about through the unique merger of two brothers, Hal and Chuck Chandler. Chuck was a test pilot who was abducted by alien Skrulls during an important test flight. Earth was seen as a strategic location in the ongoing conflict between the alien Kree and Skrull Empires, so the Skrulls were seeking information on Earth's space program and had captured Chuck to interrogate him. Chuck resisted and escaped, accidentally causing the explosion of the Skrull spacecraft in the process. While his brother Hal watched, the radiation from the explosion seemingly disintegrated Chuck, who disappeared in a burst of light. Hal later discovered, however, that the light burst had imprinted an image of Chuck on each lens of Hal's eyeglasses. Through concentration, Hal could merge the images and cause Chuck to reappear as a three-dimensional man. Chuck become the costumed adventurer known as the 3-D Man and single-handedly subverted the Skrulls' early attempts to undermine Earthly civilization.
    """)
    .with(\.thumbnail, nil)


#Preview
{
    HeroDetailView.make(heroId: Int(), middlewares: [])
}

struct HeroDetailView_Default_Previews: PreviewProvider
{

    static var previews: some View
    {
        HeroDetailView()
            .environmentObject(
                HeroDetailFeature.Store.make(
                    state: state
                )
            )
            .previewDisplayName("Default")
    }
}

struct HeroDetailView_Expanded_Previews: PreviewProvider
{

    static var previews: some View
    {
        HeroDetailView()
            .environmentObject(
                HeroDetailFeature.Store.make(
                    state: state
                        .with(\.isDescriptionExpanded, true)
                )
            )
            .previewDisplayName("Expanded")
    }
}

struct HeroDetailView_Liked_Previews: PreviewProvider
{

    static var previews: some View
    {
        HeroDetailView()
            .environmentObject(
                HeroDetailFeature.Store.make(
                    state: state
                        .with(\.liked, true)
                )
            )
            .previewDisplayName("Liked")
    }
}

