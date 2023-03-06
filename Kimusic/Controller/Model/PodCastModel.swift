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

// MARK: - PodCast
struct PodCast: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassPodCast?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassPodCast: Codable, Hashable {
    var items: [DataItemPodCast]?
    var hasMore: Bool?
    var total: Int?
}

// MARK: - DataItem
struct DataItemPodCast: Codable, Hashable {
    var sectionType, viewType, title, link: String?
    var sectionID: String?
    var items: [PurpleItemPodCast]?
    var subTitle: SubTitle?
    
    enum CodingKeys: String, CodingKey {
        case sectionType, viewType, title, link
        case sectionID = "sectionId"
        case items, subTitle
    }
}

// MARK: - PurpleItem
struct PurpleItemPodCast: Codable, Hashable {
    var id: ID?
    var encodeID, title: String?
    var thumbnail, thumbnailM, thumbnailV, thumbnailH: String?
    var itemDescription: String?
    var status: Int?
    var type: String?
    var link: String?
    var streaming: String?
    var host: Host?
    var activeUsers: Int?
    var program: PurpleProgram?
    var item: FluffyItem?
    var programs: [ProgramElement]?
    var isoffical: Bool?
    var artists: [ItemArtist]?
    var contentType, name: String?
    var rawID, duration, releaseDate: Int?
    var episode: Bool?
    var podcastID: String?
    var album: AlbumPodCast?
    var livestreamID: String?
    
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, thumbnailM, thumbnailV, thumbnailH
        case itemDescription = "description"
        case status, type, link, streaming, host, activeUsers, program, item, programs, isoffical, artists, contentType, name
        case rawID = "rawId"
        case duration, releaseDate, episode
        case podcastID = "podcastId"
        case album
        case livestreamID = "livestreamId"
    }
}

// MARK: - Album
struct AlbumPodCast: Codable, Hashable {
    var encodeID, title: String?
    var thumbnailM, thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var artists: [AlbumArtistPodCast]?
    var albumDescription, contentType, type: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnailM, thumbnail, isoffical, link, artists
        case albumDescription = "description"
        case contentType, type
    }
}


// MARK: - AlbumArtist
struct AlbumArtistPodCast: Codable, Hashable {
    var id, name, link: String?
    var cover, thumbnail: String?
}

// MARK: - ItemArtist
struct ItemArtist: Codable, Hashable {
    var id, name, link: String?
    var cover: String?
    var thumbnail: String?
}


// MARK: - Host
struct Host: Codable, Hashable {
    var name, encodeID: String?
    var thumbnail: String?
    var link: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case encodeID = "encodeId"
        case thumbnail, link
    }
}

enum ID: Codable, Hashable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(ID.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ID"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}


// MARK: - FluffyItem
struct FluffyItem: Codable, Hashable {
    var id: Int?
    var encodeID, title: String?
    var thumbnail, thumbnailM, thumbnailV, thumbnailH: String?
    var itemDescription: String?
    var status: Int?
    var type, link: String?
    var streaming: String?
    var host: Host?
    var activeUsers: Int?
    var program: PurpleProgram?
    
    enum CodingKeys: String, CodingKey {
        case id
        case encodeID = "encodeId"
        case title, thumbnail, thumbnailM, thumbnailV, thumbnailH
        case itemDescription = "description"
        case status, type, link, streaming, host, activeUsers, program
    }
}


// MARK: - PurpleProgram
struct PurpleProgram: Codable, Hashable {
    var encodeID, title: String?
    var thumbnail, thumbnailH: String?
    var programDescription: String?
    var startTime, endTime: Int?
    var hasSongRequest: Bool?
    var genreIDS: [String]?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, thumbnailH
        case programDescription = "description"
        case startTime, endTime, hasSongRequest
        case genreIDS = "genreIds"
    }
}



// MARK: - ProgramElement
struct ProgramElement: Codable, Hashable {
    var id: Int?
    var encodeID, title: String?
    var thumbnail, thumbnailH: String?
    var programDescription: String?
    var startTime, endTime: Int?
    var hasSongRequest: Bool?
    var genreIDS: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case encodeID = "encodeId"
        case title, thumbnail, thumbnailH
        case programDescription = "description"
        case startTime, endTime, hasSongRequest
        case genreIDS = "genreIds"
    }
}

// MARK: - SubTitle
struct SubTitle: Codable, Hashable {
    var id, name, link: String?
    var cover, thumbnail: String?
    var title: String?
}

