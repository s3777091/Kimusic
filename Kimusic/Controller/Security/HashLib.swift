/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Team Falava
 ID: Do Truong An (s3878698) - Le Pham Ngoc Hieu(s3877375) - Nguyen Phuc Cuong (s3881006) - Huynh Dac Tan Dat(3777091)
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement: Hashing code based on https://stackoverflow.com/questions/25388747/sha256-in-swift
 */


import Foundation
import CommonCrypto

class SecurityHash{
    func getHash256(a: String) -> String {
        return a.sha256()
    }
    
    func getHmac512(str: String, key: String) -> String {
        return hmac(algorithm: .SHA512, key: key, message: str)
        
    }
    
    func getFinalHash(hashValue: String, Slug: String, Key: String) -> String{
        let FirstHash : String = getHash256(a: hashValue)
        let SecondHash : String = getHmac512(str: Slug+FirstHash, key: ZingStruct().secret)
        return SecondHash
    }
}
extension String {
    func sha256() -> String {
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
            
        }
        return ""
        
    }
    
    private func digest(input : NSData) -> NSData {
        
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        
        var hash = [UInt8](repeating: 0, count: digestLength)
        
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        
        return NSData(bytes: hash, length: digestLength)
        
    }
    
    private func hexStringFromData(input: NSData) -> String {
        
        var bytes = [UInt8](repeating: 0, count: input.length)
        
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        
        for byte in bytes {
            
            hexString += String(format:"%02x", UInt8(byte))
            
        }
        
        return hexString
        
    }
    
}

func hmac(algorithm: CryptoAlgorithm, key: String, message: String) -> String {
    
    let str = message.cString(using: String.Encoding.utf8)
    
    let strLen = message.lengthOfBytes(using: String.Encoding.utf8)
    
    let digestLen = algorithm.digestLength
    
    let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
    
    let keyStr = key.cString(using: String.Encoding.utf8)
    
    let keyLen = key.lengthOfBytes(using: String.Encoding.utf8)
    
    CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)
    
    let digest = stringFromResult(result: result, length: digestLen)
    
    result.deallocate()
    return digest
    
}

private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
    
    var hash = String()
    
    for i in 0..<length {
        
        hash += String(format: "%02x", result[i])
        
    }
    
    return String(hash)
    
}

enum CryptoAlgorithm {
    
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        
        var result: Int = 0
        
        switch self {
            
        case .MD5: result = kCCHmacAlgMD5
            
        case .SHA1: result = kCCHmacAlgSHA1
            
        case .SHA224: result = kCCHmacAlgSHA224
            
        case .SHA256: result = kCCHmacAlgSHA256
            
        case .SHA384: result = kCCHmacAlgSHA384
            
        case .SHA512: result = kCCHmacAlgSHA512
            
        }
        
        return CCHmacAlgorithm(result)
        
    }
    
    var digestLength: Int {
        
        var result: CInt = 0
        
        switch self {
            
        case .MD5: result = CC_MD5_DIGEST_LENGTH
            
        case .SHA1: result = CC_SHA1_DIGEST_LENGTH
            
        case .SHA224: result = CC_SHA224_DIGEST_LENGTH
            
        case .SHA256: result = CC_SHA256_DIGEST_LENGTH
            
        case .SHA384: result = CC_SHA384_DIGEST_LENGTH
            
        case .SHA512: result = CC_SHA512_DIGEST_LENGTH
            
        }
        
        return Int(result)
        
    }
    
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
}

