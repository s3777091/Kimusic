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

// MARK: - ZingHub
struct ZingHub: Codable, Hashable {
    var err: Int?
    var msg: String?
    var data: DataClassHub?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClassHub: Codable, Hashable {
    var banners: [BannerHub]?
    var topTopic, topic: [GenreHub]?
    var nations: [NationHub]?
    var genre: [GenreHub]?
    var sectionID: String?

    enum CodingKeys: String, CodingKey {
        case banners, topTopic, topic, nations, genre
        case sectionID = "sectionId"
    }
}

// MARK: - Banner
struct BannerHub: Codable, Hashable {
    var cover: String?
    var link: String?
}

// MARK: - Genre
struct GenreHub: Codable, Hashable {
    var encodeID: String?
    var cover, thumbnail, thumbnailHasText, thumbnailR: String?
    var title, link, genreDescription: String?
    var playlists: [PlaylistHub]?

    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case cover, thumbnail, thumbnailHasText, thumbnailR, title, link
        case genreDescription = "description"
        case playlists
    }
}

// MARK: - Playlist
struct PlaylistHub: Codable, Hashable {
    var encodeID, title: String?
    var thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var isIndie: Bool?
    var releaseDate, sortDescription: String?
    var genreIDS: [String]?
    var pr: Bool?
    var artists: [ArtistHub]?
    var artistsNames: String?
    var playItemMode, subType, uid: Int?
    var thumbnailM: String?
    var isShuffle, isPrivate: Bool?
    var userName: String?
    var isAlbum: Bool?
    var textType: String?
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
struct ArtistHub: Codable, Hashable {
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

// MARK: - Nation
struct NationHub: Codable, Hashable {
    var encodeID: String?
    var cover, thumbnail, thumbnailHasText, thumbnailR: String?
    var title, link, nationDescription: String?

    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case cover, thumbnail, thumbnailHasText, thumbnailR, title, link
        case nationDescription = "description"
    }
}
