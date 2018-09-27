import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String?
    func decrypt(_ plaintext: String, secret: String) -> String?
}


//Dictionary extension to reverse lookup
extension Dictionary where Value: Equatable {
    func lookupValueByKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}


struct CeaserCipher: Cipher {
    /*
     Encodes the plaintext message by shifting the characters by a given value, the secret.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: encoded: String, encoded plaintext.
     */
    
    // Checks to see if the given string is alphanumeric.
    let alpha = CharacterSet.alphanumerics
    
    func encode(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        
        for uni in plaintext.unicodeScalars {
            if !alpha.contains(uni) {
                return nil
            }
        }
        
        var encoded = ""

        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    /*
     Decodes the plaintext message by shifting the characters by a given value, the secret.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: decoded: String, decoded plaintexxt.
     */
    func decrypt(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decoded = ""
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
}

struct AlphanumericCeaserCipher: Cipher {
    /*
     Encodes the plaintext message by shifting right the characters by a given value, the secret.
     Will convert all of the characters into uppercase first, then shift.
     If a character is going to be > 57 (ASCII: 9), then it will be shifted to 65, (ASCII: A).
     If a character is going to be > 90 (ASCII: Z), then it will be shifted to 48 (ASCII: 0).
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: encoded: String, encoded plaintexxt.
     @return: nil if the given plaintext is invalid.
     */
    func encode(_ plaintext: String, secret: String) -> String? {
        
        // Checks to see if the secret is valid.
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        
        // Checks to see if the given string is alphanumeric.
        let alpha = CharacterSet.alphanumerics
        for uni in plaintext.unicodeScalars {
            if !alpha.contains(uni) {
               return nil
            }
        }
        
        // Encodes the plain text and makes everything uppercase.
        let uppercasePlainText = plaintext.uppercased()
        var encoded = ""
        for character in uppercasePlainText
        {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode + shiftBy
            if shiftedUnicode > 57 && shiftedUnicode < 65
            {
                shiftedUnicode = (shiftedUnicode - 57) + 64
            }
            else if shiftedUnicode > 90
            {
                shiftedUnicode = (shiftedUnicode - 90) + 47
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    /*
     Decodes the plaintext message by shifting left the characters by a given value, the secret.
     If a character is going to be < 48 (ASCII: 9), then it will be shifted to 90, (ASCII: Z).
     If a character is going to be < 65 (ASCII: A), then it will be shifted to 57 (ASCII: 9).
     The decoded message will be in all uppercase letters regardless of the original message.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: encoded: String, encoded plaintexxt.
     */
    func decrypt(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decoded = ""
        for character in plaintext
        {
            let unicode = character.unicodeScalars.first!.value
            var shiftedUnicode = unicode - shiftBy
            if shiftedUnicode < 48
            {
                shiftedUnicode = shiftedUnicode + 90 - 47
            }
            else if shiftedUnicode < 65 && shiftedUnicode > 58
            {
                shiftedUnicode = shiftedUnicode - 7
            }
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
}

struct AlBhedCipher: Cipher {
    
    //Cipher from Final Fantasy X that maps each letter to another letter.
    let englishToAlBhed =
    [
        "a": "y",
        "b": "p",
        "c": "l",
        "d": "t",
        "e": "a",
        "f": "v",
        "g": "k",
        "h": "r",
        "i": "e",
        "j": "z",
        "k": "g",
        "l": "m",
        "m": "s",
        "n": "h",
        "o": "y",
        "p": "b",
        "q": "x",
        "r": "n",
        "s": "c",
        "t": "d",
        "u": "i",
        "v": "j",
        "w": "f",
        "x": "q",
        "y": "o",
        "z": "w"
    ]
    /*
     Encodes a plaintext message using the Al Bhed language cipher from Final Fantasy X.
     This cipher will ignore numeric and plain characters, convert everything to lowercase,
     and then map each letter to a letter in the Al Bhed language.
     @param: plaintext: String, the text to encode.
     @param: secret: Not used.
     @return: encoded: String, encoded plaintext.
     */
    func encode(_ plaintext: String, secret: String) -> String? {
        
        // Checks to see if the secret is valid.
        var shiftBy = UInt32(secret)
        shiftBy = 0
        
        //Encodes
        var encoded = ""
        let lowercase = plaintext.lowercased()
        for character in lowercase
        {
            let stringLetter = String(character)
            if let translatedLetter = englishToAlBhed[stringLetter]
            {
                encoded = encoded + translatedLetter
            }
            else
            {
                encoded = encoded + stringLetter
            }
        }
        // Encodes the plain text and makes everything uppercase.
        return encoded
    }
    
    /*
     Decodes the plaintext message by doing a reverse dictionary lookup using
     an extension of the dictionary class.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: encoded: String, encoded plaintext.
     */
    func decrypt(_ plaintext: String, secret: String) -> String? {
        
        // Checks to see if the secret is valid.
        var shiftBy = UInt32(secret)
        shiftBy = 0
        
        //Decoding process
        var decoded = ""
        for character in plaintext
        {
            let stringLetter = String(character)
            if let key = englishToAlBhed.lookupValueByKey(forValue: stringLetter)
            {
                decoded = decoded + key
            }
            else
            {
                decoded = decoded + stringLetter
            }
        }
        return decoded
    }
}

struct AlphabetIndexCipher: Cipher {

    /*
     Encodes the plaintext message by indexing all the letters to
     their corresponding position in the alphabet with A being 1.
     Converts all of the characters to lowercase before performing the operation.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: encoded: String, encoded plaintext.
     */
    
    func encode(_ plaintext: String, secret: String) -> String? {
        // Unwrap the secret to see if it is valid.
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        
        // Checks to see if the given string is alphanumeric.
        let alpha = CharacterSet.alphanumerics
        for uni in plaintext.unicodeScalars {
            if !alpha.contains(uni) {
                return nil
            }
        }
        
        var encoded = ""
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode * shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    
    /*
     Decodes the plaintext message by shifting the characters by a given value, the secret.
     @param: plaintext: String, the text to encode.
     @param: secret: String, a numerical value in String form to shift the plaintext by.
     @return: decoded: String, decoded plaintexxt.
     */
    func decrypt(_ plaintext: String, secret: String) -> String? {
        guard let shiftBy = UInt32(secret) else {
            return nil
        }
        var decoded = ""
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode / shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
}
