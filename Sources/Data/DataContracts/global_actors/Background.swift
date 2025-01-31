public actor BackgroundActor
{}

@globalActor
public struct Background
{
    public static let shared = BackgroundActor()
}
