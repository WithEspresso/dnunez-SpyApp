import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceasar": CeaserCipher(),
        "Alphanumeric Ceaser": CeaserCipher(),
        "Al Bhed": AlBhedCipher(),
        "Alphabet Index": AlphabetIndexCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
