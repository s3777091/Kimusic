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

// MARK: - ZingHome2
struct ZingHome2: Codable {
    var err: Int?
    var msg: String?
    var data: DataClass2?
    var timestamp: Int?
}

// MARK: - DataClass
struct DataClass2: Codable {
    var items: [DataItem2]?
    var hasMore: Bool?
    var total: Int?
}

// MARK: - DataItem
struct DataItem2: Codable {
    var sectionID, sectionType, title, viewType: String?
    var isShuffle: Bool?
    var items: [ItemItem2]?
    var link: String?
    var chart: Chart?
    var chartType: String?
    
    enum CodingKeys: String, CodingKey {
        case sectionID = "sectionId"
        case sectionType, title, viewType, isShuffle, items, link, chart, chartType
    }
}

// MARK: - Chart
struct Chart: Codable {
    var times: [Time]?
    var minScore: Int?
    var maxScore: Double?
    var items: [String: [ChartItem]]?
    var totalScore: Int?
}

// MARK: - ChartItem
struct ChartItem: Codable {
    var time: Int?
    var hour: String?
    var counter: Int?
}

// MARK: - Time
struct Time: Codable {
    var hour: String?
}

// MARK: - ItemItem
struct ItemItem2: Codable {
    var encodeID, title: String?
    var thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var isIndie: Bool?
    var releaseDate: ReleaseDate?
    var sortDescription: String?
    var genreIDS: [String]?
    var pr: Bool?
    var artists: [ArtistElement2]?
    var artistsNames: String?
    var playItemMode, subType, uid: Int?
    var thumbnailM: String?
    var isShuffle, isPrivate: Bool?
    var userName: String?
    var isAlbum: Bool?
    var textType: String?
    var isSingle: Bool?
    var song: Song2?
    var alias: String?
    var isOffical: Bool?
    var username: String?
    var isWorldWide: Bool?
    var duration: Int?
    var zingChoice, preRelease: Bool?
    var album: Album2?
    var indicators: [JSONAny]?
    var streamingStatus: Int?
    var allowAudioAds, hasLyric: Bool?
    var rakingStatus, score, totalTopZing: Int?
    var artist: PurpleArtist2?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription
        case genreIDS = "genreIds"
        case pr = "PR"
        case artists, artistsNames, playItemMode, subType, uid, thumbnailM, isShuffle, isPrivate, userName, isAlbum, textType, isSingle, song, alias, isOffical, username, isWorldWide, duration, zingChoice, preRelease, album, indicators, streamingStatus, allowAudioAds, hasLyric, rakingStatus, score, totalTopZing, artist
    }
}

// MARK: - Album
struct Album2: Codable {
    var encodeID, title: String?
    var thumbnail: String?
    var isoffical: Bool?
    var link: String?
    var isIndie: Bool?
    var releaseDate, sortDescription: String?
    var genreIDS: [String]?
    var pr: Bool?
    var artists: [ArtistElement2]?
    var artistsNames: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, thumbnail, isoffical, link, isIndie, releaseDate, sortDescription
        case genreIDS = "genreIds"
        case pr = "PR"
        case artists, artistsNames
    }
}

// MARK: - ArtistElement
struct ArtistElement2: Codable {
    var id, name, link: String?
    var spotlight: Bool?
    var alias: String?
    var thumbnail, thumbnailM: String?
    var isOA, isOABrand: Bool?
    var totalFollow: Int?
    var playlistID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, spotlight, alias, thumbnail, thumbnailM, isOA, isOABrand, totalFollow
        case playlistID = "playlistId"
    }
}

// MARK: - PurpleArtist
struct PurpleArtist2: Codable {
    var id, name, link: String?
    var spotlight: Bool?
    var alias, playlistID: String?
    var cover: String?
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, link, spotlight, alias
        case playlistID = "playlistId"
        case cover, thumbnail
    }
}

enum ReleaseDate: Codable {
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
        throw DecodingError.typeMismatch(ReleaseDate.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ReleaseDate"))
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

// MARK: - Song
struct Song2: Codable {
    var total: Int?
    var items: [SongItem2]?
}

// MARK: - SongItem
struct SongItem2: Codable {
    var encodeID, title, alias: String?
    var isOffical: Bool?
    var username, artistsNames: String?
    var artists: [ArtistElement2]?
    var isWorldWide: Bool?
    var thumbnailM: String?
    var link: String?
    var thumbnail: String?
    var duration: Int?
    var zingChoice, isPrivate, preRelease: Bool?
    var releaseDate: Int?
    var genreIDS: [String]?
    var album: Album2?
    var indicators: [JSONAny]?
    var isIndie: Bool?
    var streamingStatus: Int?
    var allowAudioAds, hasLyric: Bool?
    var radioID: Int?
    var mvlink: String?
    
    enum CodingKeys: String, CodingKey {
        case encodeID = "encodeId"
        case title, alias, isOffical, username, artistsNames, artists, isWorldWide, thumbnailM, link, thumbnail, duration, zingChoice, isPrivate, preRelease, releaseDate
        case genreIDS = "genreIds"
        case album, indicators, isIndie, streamingStatus, allowAudioAds, hasLyric
        case radioID = "radioId"
        case mvlink
    }
    
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    
    let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
