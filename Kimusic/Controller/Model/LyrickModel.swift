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
// MARK: - Lyrick
struct LyrickModel: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassLyrick?
    var timestamp: Int?
}


// MARK: - DataClass
struct DataClassLyrick: Codable, Hashable {
    var sentences: [Sentence]?
    var file: String?
    var enabledVideoBG: Bool?
    var defaultIBGUrls: [String]?
    var defaultVBGUrls: [String]?
    var bgMode: Int?
    
    enum CodingKeys: String, CodingKey {
        case sentences, file, enabledVideoBG, defaultIBGUrls, defaultVBGUrls
        case bgMode = "BGMode"
    }
}


// MARK: - Sentence
struct Sentence: Codable, Hashable {
    var words: [Word]?
}

// MARK: - Word
struct Word: Codable, Hashable {
    var startTime, endTime: Int?
    var data: String?
}
