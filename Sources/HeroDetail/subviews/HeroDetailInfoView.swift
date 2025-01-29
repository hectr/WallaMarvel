import SwiftUI
import LeanRedux

struct HeroDetailInfoView: View
{
    // MARK: Dependencies

    @EnvironmentObject
    private var store: HeroDetailReducer.Store

    @Environment(\.lexemes)
    private var lexemes: Lexemes

    // MARK: Content

    private var viewState: State
    {
        State(state: store.state)
    }

    var body: some View
    {
        VStack(alignment: .leading, spacing: viewState.verticalSpacing) {
            // name
            HStack {
                Text(viewState.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(
                        color: .black,
                        radius: viewState.shadowRadius,
                        x: viewState.shadowX,
                        y: viewState.shadowY
                    )
                Spacer()
            }

            // description
            if viewState.isDescriptionExpanded {
                Text(viewState.descriptionText)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray5))
            } else {
                Text(viewState.descriptionText)
                    .font(.subheadline)
                    .foregroundColor(Color(.systemGray5))
                    .lineLimit(viewState.collapsedLinesLimit)
            }

            // Show more
            Text(viewState.isDescriptionExpanded ? lexemes.showLess : lexemes.showMore)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGray5))
                .onTapGesture {
                    withAnimation(.spring()) {
                        store.dispatch(.toggleDescription)
                    }
                }
        }
    }

    // MARK: View State

    struct State: DTO
    {
        var collapsedLinesLimit = 2
        var descriptionText: String
        var isDescriptionExpanded: Bool
        var name: String
        var shadowRadius = 1.0
        var shadowX = 1.0
        var shadowY = 1.0
        var verticalSpacing = 20.0

        init(state: HeroDetailReducer.State)
        {
            self.descriptionText = state.heroDescription
            self.isDescriptionExpanded = state.isDescriptionExpanded
            self.name = state.name
        }
    }
}

// MARK: - Preview

struct HeroDetailInfoView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HeroDetailInfoView()
            .background(.pink)
            .environmentObject(
                HeroDetailReducer.Store.make(
                    middlewares: [],
                    reducer: HeroDetailReducer.reduce,
                    state: HeroDetailReducer.State()
                        .with(\.isDescriptionExpanded, true)
                        .with(\.name, "3-D Man")
                        .with(\.heroDescription, """
                        The 3-D Man was a 1950's hero who came about through the unique merger of two brothers, Hal and Chuck Chandler. Chuck was a test pilot who was abducted by alien Skrulls during an important test flight. Earth was seen as a strategic location in the ongoing conflict between the alien Kree and Skrull Empires, so the Skrulls were seeking information on Earth's space program and had captured Chuck to interrogate him. Chuck resisted and escaped, accidentally causing the explosion of the Skrull spacecraft in the process. While his brother Hal watched, the radiation from the explosion seemingly disintegrated Chuck, who disappeared in a burst of light. Hal later discovered, however, that the light burst had imprinted an image of Chuck on each lens of Hal's eyeglasses. Through concentration, Hal could merge the images and cause Chuck to reappear as a three-dimensional man. Chuck become the costumed adventurer known as the 3-D Man and single-handedly subverted the Skrulls' early attempts to undermine Earthly civilization.
                        """)
                )
            )
    }
}
