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

// MARK: - NewMusic
struct NewMusic: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassNewMusic?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassNewMusic: Codable, Hashable {
    var banner: String?
    var type, link, title, sectionType: String?
    var sectionID, viewType: String?
    var items: [ItemNewMusic]?

    enum CodingKeys: String, CodingKey {
        case banner, type, link, title, sectionType
        case sectionID = "sectionId"
        case viewType, items
    }
}


// MARK: - Item
struct ItemNewMusic: Codable, Hashable {
    var encodeID, title, alias: String?
    var isOffical: Bool?
    var username, artistsNames: String?
    var artists: [ItemArtistNewMusic]?
    var isWorldWide: Bool?
    var thumbnailM: String?
    var link: String?
    var thumbnail: String?
    var duration: Int?
    var zingChoice, isPrivate, preRelease: Bool?
    var releaseDate: Int?
    var genreIDS: [String]?
    var album: AlbumNewMusic?
    var indicators: [String]?
    var isIndie: Bool?
    var streamingStatus: Int?
    var allowAudioAds, hasLyric: Bool?
    var rakingStatus, releasedAt: Int?
    var mvlink: String?

    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, alias, isOffical, username, artistsNames, artists, isWorldWide, thumbnailM, link, thumbnail, duration, zingChoice, isPrivate, preRelease, releaseDate
        case genreIDS = "genreIds"
        case album, indicators, isIndie, streamingStatus, allowAudioAds, hasLyric, rakingStatus, releasedAt, mvlink
    }
}

// MARK: - Album
struct AlbumNewMusic: Codable, Hashable {
    var encodeID, title: String?
    var thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var isIndie: Bool?
    var releaseDate, sortDescription: String?
    var genreIDS: [String]?
    var pr: Bool?
    var artists: [AlbumArtistNewMusic]?
    var artistsNames: String?

    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription
        case genreIDS = "genreIds"
        case pr = "PR"
        case artists, artistsNames
    }
}


// MARK: - AlbumArtist
struct AlbumArtistNewMusic: Codable, Hashable {
    var id, name, link: String?
    var spotlight: Bool?
    var alias: String?
    var thumbnail, thumbnailM: String?
    var isOA, isOABrand: Bool?
    var playlistID: String?
    var totalFollow: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, link, spotlight, alias, thumbnail, thumbnailM, isOA, isOABrand
        case playlistID = "playlistId"
        case totalFollow
    }
}

// MARK: - ItemArtist
struct ItemArtistNewMusic: Codable, Hashable {
    var id, name, link: String?
    var spotlight: Bool?
    var alias: String?
    var thumbnail, thumbnailM: String?
    var isOA, isOABrand: Bool?
    var playlistID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, link, spotlight, alias, thumbnail, thumbnailM, isOA, isOABrand
        case playlistID = "playlistId"
    }
}
