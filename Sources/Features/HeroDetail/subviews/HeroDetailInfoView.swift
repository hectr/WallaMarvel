import SwiftUI
import LeanRedux

struct HeroDetailInfoView: View
{
    // MARK: Dependencies

    @EnvironmentObject
    private var store: HeroDetailFeature.Store

    @Environment(\.lexemes)
    private var lexemes: Lexemes

    // MARK: State

    @State
    private var canBeExpanded = false

    // MARK: Content

    private var viewState: ViewState
    {
        ViewState(state: store.state)
    }

    var body: some View
    {
        VStack(alignment: .leading, spacing: viewState.verticalSpacing) {
            name
            if !viewState.descriptionText.isEmpty {
                description
                if canBeExpanded || viewState.isDescriptionExpanded {
                    showMore
                }
            }
        }
    }

    /// Hero name view.
    private var name: some View
    {
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
    }

    /// Hero description view.
    @ViewBuilder
    private var description: some View
    {
        if viewState.isDescriptionExpanded {
            descriptionStyledText
        } else {
            descriptionStyledText
                .lineLimit(viewState.collapsedLinesLimit)
                .background {
                    // Background matches the size of the Text...
                    if #available(iOS 16.0, *) {
                        ViewThatFits(in: .vertical) {
                            // ... and `ViewThatFits` picks the first child that fits vertically:
                            descriptionStyledText.hidden().onAppear {
                                // - if it's the text, it means you cannot expand it more;
                                canBeExpanded = false
                            }
                            Color.clear.onAppear {
                                // - otherwise, it means yo can expand it.
                                canBeExpanded = true
                            }
                        }
                    }
                }
        }
    }

    /// A `Text` component with the 'hero description' style.
    private var descriptionStyledText: some View
    {
        Text(viewState.descriptionText)
            .font(.subheadline)
            .foregroundColor(Color(.white))
    }

    /// Show More/Less view.
    private var showMore: some View
    {
        Text(viewState.isDescriptionExpanded ? lexemes.showLess : lexemes.showMore)
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(Color(.white))
            .onTapGesture {
                withAnimation(.spring()) {
                    store.dispatch(.toggleDescription)
                }
            }
    }

    // MARK: View State

    struct ViewState: DTO
    {
        var collapsedLinesLimit = 2
        var descriptionText: String
        var isDescriptionExpanded: Bool
        var name: String
        var shadowRadius = 1.0
        var shadowX = 1.0
        var shadowY = 1.0
        var verticalSpacing = 20.0

        init(state: HeroDetailFeature.State)
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
                HeroDetailFeature.Store.make(
                    middlewares: [],
                    reducer: HeroDetailFeature.reduce,
                    state: HeroDetailFeature.State()
                        .with(\.isDescriptionExpanded, true)
                        .with(\.name, "3-D Man")
                        .with(\.heroDescription, """
                        The 3-D Man was a 1950's hero who came about through the unique merger of two brothers, Hal and Chuck Chandler. Chuck was a test pilot who was abducted by alien Skrulls during an important test flight. Earth was seen as a strategic location in the ongoing conflict between the alien Kree and Skrull Empires, so the Skrulls were seeking information on Earth's space program and had captured Chuck to interrogate him. Chuck resisted and escaped, accidentally causing the explosion of the Skrull spacecraft in the process.
                        """)
                )
            )
    }
}
