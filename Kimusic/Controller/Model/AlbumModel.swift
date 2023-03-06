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

// MARK: - ZingAlbum
struct ZingAlbum: Codable, Hashable {
    let err: Int?
    let msg: String?
    let data: DataClassAlbum?
    let timestamp: Int?
}


// MARK: - DataClass
struct DataClassAlbum: Codable, Hashable {
    let encodeId, title: String?
    let thumbnail: String?
    let isoffical: Bool?
    let link: String?
    let isIndie: Bool?
    let releaseDate, sortDescription: String?
    let genreIds: [String]?
    let pr: Bool?
    let artists: [ArtistElement]?
    let artistsNames: String?
    let playItemMode, subType, uid: Int?
    let thumbnailM: String?
    let isShuffle, isPrivate: Bool?
    let userName: String?
    let isAlbum: Bool?
    let textType: String?
    let isSingle: Bool?
    let dataDescription, aliasTitle, sectionId: String?
    let contentLastUpdate: Int?
    let artist: PurpleArtist?
    let genres: [Genre]?
    let song: SongAlbumTab?
    let like, listen: Int?
    let liked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case encodeId, title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription, genreIds
        case pr
        case artists, artistsNames, playItemMode, subType, uid, thumbnailM, isShuffle, isPrivate, userName, isAlbum, textType, isSingle
        case dataDescription
        case aliasTitle, sectionId, contentLastUpdate, artist, genres, song, like, listen, liked
    }
}

// MARK: - PurpleArtist
struct PurpleArtist: Codable, Hashable {
    let id, name, link: String?
    let spotlight: Bool?
    let alias, playlistId: String?
    let cover, thumbnail: String?
}

// MARK: - ArtistElement
struct ArtistElement: Codable, Hashable {
    let id, name, link: String?
    let spotlight: Bool?
    let alias: String?
    let thumbnail, thumbnailM: String?
    let isOa, isOaBrand: Bool?
    let playlistId: String?
    let totalFollow: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, spotlight, alias, thumbnail, thumbnailM
        case isOa
        case isOaBrand
        case playlistId, totalFollow
    }
}


// MARK: - Genre
struct Genre: Codable, Hashable {
    let id, name, title, alias: String?
    let link: String?
}


// MARK: - Song
struct SongAlbumTab: Codable, Hashable {
    let items: [Item]?
    let total, totalDuration: Int?
}


// MARK: - Item
struct Item: Codable, Hashable , Identifiable{
    let encodeId, title, alias: String?
    let isOffical: Bool?
    let username, artistsNames: String?
    let artists: [ArtistElement]?
    let isWorldWide: Bool?
    let thumbnailM: String?
    let link: String?
    let thumbnail: String?
    let duration: Int?
    let zingChoice, isPrivate, preRelease: Bool?
    let releaseDate: Int?
    let genreIds: [String]?
    let album: Album?
    let indicators: [String]?
    let isIndie: Bool?
    let streamingStatus: Int?
    let allowAudioAds, hasLyric: Bool?
    let radioId: Int?
    let mvlink: String?
    
    var id : String?{
        encodeId
    }
}


// MARK: - Album
struct Album: Codable, Hashable {
    let encodeId, title: String?
    let thumbnail: String?
    let isoffical: Bool?
    let link: String?
    let isIndie: Bool?
    let releaseDate, sortDescription: String?
    let genreIds: [String]?
    let pr: Bool?
    let artists: [ArtistElement]?
    let artistsNames: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeId, title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription, genreIds
        case pr
        case artists, artistsNames
    }
}
