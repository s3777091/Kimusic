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
struct Episode: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassEpisode?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassEpisode: Codable, Hashable {
    var items: [ItemEpisode]?
    var total: Int?
    var hasMore: Bool?
}

// MARK: - Item
struct ItemEpisode: Codable, Hashable {
    var encodeID: String?
    var rawID: Int?
    var title, itemDescription: String?
    var duration: Int?
    var thumbnail, thumbnailM: String?
    var artists: [Artist]?
    var link: String?
    var releaseDate: Int?
    var contentType: String?
    var episode: Bool?
    var podcastID: String?
    var album: AlbumEpisode?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case rawID = "rawId"
        case title
        case itemDescription = "description"
        case duration, thumbnail, thumbnailM, artists, link, releaseDate, contentType, episode
        case podcastID = "podcastId"
        case album
    }
}

// MARK: - Album
struct AlbumEpisode: Codable, Hashable {
    var encodeID, title: String?
    var thumbnailM, thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var artists: [ArtistEpisode]?
    var albumDescription, contentType, type: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnailM, thumbnail, isoffical, link, artists
        case albumDescription = "description"
        case contentType, type
    }
}

// MARK: - Artist
struct ArtistEpisode: Codable, Hashable {
    var id, name, link: String?
    var cover, thumbnail: String?
}

