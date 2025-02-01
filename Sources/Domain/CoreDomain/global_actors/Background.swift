actor BackgroundActor
{}

@globalActor
struct Background
{
    static let shared = BackgroundActor()
}
