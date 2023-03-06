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

// MARK: - Episode
struct EpisodePodCastListCategory: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassPodCastListCategory?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassPodCastListCategory: Codable, Hashable {
    var items: [ItemPodCastListCategory]?
    var hasMore: Bool?
}

// MARK: - Item
struct ItemPodCastListCategory: Codable, Hashable {
    var encodeID, title: String?
    var thumbnailM, thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var artists: [ArtistPodCastListCategory]?
    var itemDescription, contentType, type: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnailM, thumbnail, isoffical, link, artists
        case itemDescription = "description"
        case contentType, type
    }
}


// MARK: - Artist
struct ArtistPodCastListCategory: Codable, Hashable {
    var id, name, link: String?
    var cover, thumbnail: String?
}

