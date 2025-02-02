// Generated using Sourcery 2.2.4 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// Command: Scripts/generate_mocks.sh --target=Networking --sources-path=Sources/Core --import=Collections

@testable import Networking
import Collections

// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif
























public class EndpointMock: Endpoint {

    public init() {}

    public var method: HTTPMethod {
        get { return underlyingMethod }
        set(value) { underlyingMethod = value }
    }
    public var underlyingMethod: (HTTPMethod)!
    public var baseUrl: String {
        get { return underlyingBaseUrl }
        set(value) { underlyingBaseUrl = value }
    }
    public var underlyingBaseUrl: (String)!
    public var path: String {
        get { return underlyingPath }
        set(value) { underlyingPath = value }
    }
    public var underlyingPath: (String)!
    public var query: OrderedDictionary<String, CustomStringConvertible?> {
        get { return underlyingQuery }
        set(value) { underlyingQuery = value }
    }
    public var underlyingQuery: (OrderedDictionary<String, CustomStringConvertible?>)!
    public var responseDeserializer: Deserializer {
        get { return underlyingResponseDeserializer }
        set(value) { underlyingResponseDeserializer = value }
    }
    public var underlyingResponseDeserializer: (Deserializer)!



}
public class NetworkProviderMock: NetworkProvider {

    public init() {}



    //MARK: - performRequest

    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestCallsCount = 0
    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestCalled: Bool {
        return performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestCallsCount > 0
    }
    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReceivedArguments: (endpoint: Endpoint, completion: Completion)?
    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReceivedInvocations: [(endpoint: Endpoint, completion: Completion)] = []
    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReturnValue: OngoingRequest?
    public var performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure: ((Endpoint, @escaping Completion) -> OngoingRequest?)?

    public func performRequest(to endpoint: Endpoint, completion: @escaping Completion) -> OngoingRequest? {
        performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestCallsCount += 1
        performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReceivedArguments = (endpoint: endpoint, completion: completion)
        performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReceivedInvocations.append((endpoint: endpoint, completion: completion))
        if let performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure = performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure {
            return performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestClosure(endpoint, completion)
        } else {
            return performRequestToEndpointEndpointCompletionEscapingCompletionOngoingRequestReturnValue
        }
    }


}

