import Foundation

/// A persistent key-value store.
///
/// sourcery: AutoMockable
protocol PersistentStoreProtocol
{
    func set(_ value: Bool, forKey defaultName: String)
    func bool(forKey defaultName: String) -> Bool
}

extension UserDefaults: PersistentStoreProtocol
{}
