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

// MARK: - PodCastListen
struct PodCastPlayer: Codable {
    var err: Int?
    var msg: String?
    var data: DataClassPodCastPlayer?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassPodCastPlayer: Codable {
    var the64, the128: String?
    
    enum CodingKeys: String, CodingKey {
        case the64 = "64"
        case the128 = "128"
    }
}
