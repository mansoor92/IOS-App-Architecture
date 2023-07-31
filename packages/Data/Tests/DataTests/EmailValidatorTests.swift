import XCTest
@testable import Data

final class EmailValidatorTests: XCTestCase {
    
    private var sut: EmailValidator!
    
    override func setUpWithError() throws {
        sut = EmailValidator()
    }
    
    func test_empty_email() throws {
        XCTAssertFalse(sut.isValid(email: ""))
    }
    
    func test_missing_at_sign() throws {
        XCTAssertFalse(sut.isValid(email: "mali-gmail.com"))
    }
    
    func test_missing_dot_com() throws {
        XCTAssertFalse(sut.isValid(email: "mali-gmail"))
        XCTAssertFalse(sut.isValid(email: "mali-gmail.c"))
    }
    
    func test_email_format() throws {
        XCTAssertTrue(sut.isValid(email: "mali@gmail.com"))
    }
}
