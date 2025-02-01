@testable import CoreDomain
import CryptoKit
import Foundation
import Testing

@Suite
struct StringMD5Tests
{
    @Test("When calling md5 on a string, it correctly computes the MD5 hash")
    func md5Hashing()
    {
        // Given
        let input = "Hello, world!"
        let expectedHash = "6cd3556deb0da54bca060b4c39479839" // source: https://www.md5hashgenerator.com/

        // When
        let result = input.md5

        // Then
        #expect(result == expectedHash, "Expected MD5 hash to be \(expectedHash), but got \(result)")
    }
}
