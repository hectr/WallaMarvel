import Foundation
import Networking

public class DeserializerMock: Deserializer, @unchecked Sendable
{
    public init()
    {}

    //MARK: - deserialize<T: Decodable>

    public var deserializeThrowableError: (any Error)?
    public var deserializeCallsCount = 0
    public var deserializeCalled: Bool {
        return deserializeCallsCount > 0
    }
    public var deserializeReceivedData: (Data)?
    public var deserializeReceivedInvocations: [(Data)] = []
    public var deserializeReturnValue: Any!
    public var deserializeClosure: ((Data) throws -> Any)?

    public func deserialize<T: Decodable>(data: Data) throws -> T {
        deserializeCallsCount += 1
        deserializeReceivedData = data
        deserializeReceivedInvocations.append(data)
        if let error = deserializeThrowableError {
            throw error
        }
        if let deserializeClosure = deserializeClosure {
            return try deserializeClosure(data) as! T
        } else {
            return deserializeReturnValue as! T
        }
    }
}
