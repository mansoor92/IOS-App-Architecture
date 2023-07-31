//
//  UserCredentialTests.swift
//  
//
//  Created by Mansoor Ali on 31/07/2023.
//

import XCTest
@testable import Data

final class UserCredentialTests: XCTestCase {

    private var sut: UserCredential!
    

    func test_empty_credentials() throws {
        XCTAssertNil(try? UserCredential(email: "", password: ""))
    }
    
    func test_empty_email() throws {
        XCTAssertNil(try? UserCredential(email: "", password: "1234"))
    }
    
    func test_empty_password() throws {
        XCTAssertNil(try? UserCredential(email: "mali@gmail.com", password: ""))
    }
    
    func test_valid_credentials() throws {
        XCTAssertNoThrow(try UserCredential(email: "mali@gmail.com", password: "123"))
    }
}
