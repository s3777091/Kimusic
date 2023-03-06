 /*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Huynh Dac Tan Dat(3777091)
 Created  date: 17/09/2022
 Last modified: 17/09/2022
  Acknowledgement: Code generated from feeding api into https://app.quicktype.io/
 */

import Foundation

import Foundation

// MARK: - ZingListen
struct ZingListen: Codable {
    let err: Int?
    let msg: String?
    let data: DataClassMusic?
    let timestamp: Int?
}


// MARK: - DataClass
struct DataClassMusic: Codable {
    let the128: String?
    let the320: String?
    
    enum CodingKeys: String, CodingKey {
        case the128 = "128"
        case the320 = "320"
    }
}
