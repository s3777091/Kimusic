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

// MARK: - Top100
struct Top100: Codable {
    var err: Int?
    var msg: String?
    var data: [DatumTop100]?
    var timestamp: Int?
}

// MARK: - Datum
struct DatumTop100: Codable {
    var sectionType, viewType, title, link: String?
    var sectionID: String?
    var items: [ItemTop100]?
    var genre: Genre?
    
    enum CodingKeys: String, CodingKey {
        case sectionType, viewType, title, link
        case sectionID = "sectionId"
        case items, genre
    }
}

// MARK: - Genre
struct GenreTop100: Codable {
    var name: String?
}

// MARK: - Item
struct ItemTop100: Codable {
    var encodeID, title: String?
    var thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var isIndie: Bool?
    var releaseDate, sortDescription: String?
    var genreIDS: [String]?
    var pr: Bool?
    var artists: [ArtistTop100]?
    var artistsNames: ArtistsNamesTop100?
    var playItemMode, subType, uid: Int?
    var thumbnailM: String?
    var isShuffle, isPrivate: Bool?
    var userName: UserName?
    var isAlbum: Bool?
    var textType: TextType?
    var isSingle: Bool?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription
        case genreIDS = "genreIds"
        case pr = "PR"
        case artists, artistsNames, playItemMode, subType, uid, thumbnailM, isShuffle, isPrivate, userName, isAlbum, textType, isSingle
    }
}

// MARK: - Artist
struct ArtistTop100: Codable {
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

enum ArtistsNamesTop100: String, Codable {
    case nhiềuNghệSĩ = "Nhiều nghệ sĩ"
}

enum TextType: String, Codable {
    case playlist = "Playlist"
}

enum UserName: String, Codable {
    case zingMP3 = "Zing MP3"
}
