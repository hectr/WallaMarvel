import SwiftUI
import LeanRedux

public struct HeroDetailView: View
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

    public var body: some View
    {
        ZStack{
            HeroDetailBackgroundView()
            VStack{
                HeroDetailHeaderView()
                ScrollView {
                    Image(systemName: "icloud.slash")
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

    public static func make(heroId: Int) -> some View
    {
        HeroDetailView()
            .environmentObject(
                HeroDetailReducer.Store.make(
                    middlewares: [],
                    reducer: HeroDetailReducer.reduce,
                    state: HeroDetailReducer.State()
                        .with(\.selectedHeroId, heroId)
                )
            )
    }

    // MARK: View State

    struct State: DTO
    {
        var isDescriptionExpanded: Bool

        init(state: HeroDetailReducer.State)
        {
            self.isDescriptionExpanded = state.isDescriptionExpanded
        }
    }
}

// MARK: - Preview

struct HeroDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetailView.make(heroId: Int())
    }
}
