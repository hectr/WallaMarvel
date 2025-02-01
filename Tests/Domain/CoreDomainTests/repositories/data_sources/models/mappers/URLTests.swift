@testable import CoreDomain
import CoreDomainContracts
import Testing
import Foundation

@Suite
struct URLTests
{
    @Test("When mapping Thumbnail to URL, it correctly constructs the URL")
    func fromDataModel()
    {
        // Given
        let thumbnail = Thumbnail(path: "http://example.com/image", extension: "jpg")
        
        // When
        let url = URL(thumbnail)
        
        // Then
        #expect(url?.absoluteString == "http://example.com/image/portrait_small.jpg")
    }
}
