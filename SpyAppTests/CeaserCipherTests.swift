import XCTest
@testable import SpyApp

class CeaserCipherTests: XCTestCase {

    var cipher: Cipher!

    override func setUp() {
        super.setUp()
        cipher = CeaserCipher()
    }

    func test_oneCharacterStirngGetsMappedToSelfWith_0_secret() {
        let plaintext = "a"

        let result = cipher.encode(plaintext, secret: "0")

        XCTAssertEqual(plaintext, result)
    }

    func test_nonNumericInputForSecret() {
        let result = cipher.encode("b", secret: "nonNumericString")

        XCTAssertNil(result)
    }
}

class AlphanumericCeaserCiphertests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = AlphanumericCeaserCipher()
    }
    
    func test_Z_goes_to_Zero() {
        let plaintext = "Z"
        let expected_result = "0"
        
        let result = cipher.encode(plaintext, secret: "1")
        
        XCTAssertEqual(expected_result, result)
    }
    
    func test_letter_goes_to_itself() {
        let plaintext = "A"
        let result = cipher.encode("A", secret: "0")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_nonNumericInputForSecret() {
        let result = cipher.encode("b", secret: "nonNumericString")
        
        XCTAssertNil(result)
    }
}

class AlBhedCipherTests: XCTestCase {
    
    var cipher: Cipher!
    override func setUp() {
        super.setUp()
        cipher = AlBhedCipher()
    }
    
    func test_number_goes_to_itself() {
        let plaintext = "5"
        let result = cipher.encode("5", secret: "0")
        
        XCTAssertEqual(plaintext, result)
    }
    
    // A is Y in Al Bhed
    func test_letter_goes_to_mapped_letter() {
        let plaintext = "a"
        let expected_result = "y"
        let result = cipher.encode(plaintext, secret: "y")
        
        XCTAssertEqual(expected_result, result)
    }
    
    func test_nonAlphabeticInputForSecret() {
        let result = cipher.encode("1234", secret: "0")
        let expected_result = "1234"
        
        XCTAssertEqual(expected_result, result)
    }
}

class UnicodeCipherTests: XCTestCase {
    
    var cipher: Cipher!
    
    override func setUp() {
        super.setUp()
        cipher = UnicodeCipher()
    }
    
    func test_oneCharacterStirngGetsMappedToSelfWith_0_secret() {
        let plaintext = "A"
        
        let result = cipher.encode(plaintext, secret: "0")
        
        XCTAssertEqual(plaintext, result)
    }
    
    func test_nonNumericInputForSecret() {
        let result = cipher.encode("b", secret: "nonNumericString")
        
        XCTAssertNil(result)
    }
}
