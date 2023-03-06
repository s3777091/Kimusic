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

import SwiftUI
import AVKit
import FirebaseFirestore
import FirebaseFirestoreSwift

enum APIError: Error {
    case error(String)
    
    var localizedDescription: String {
        switch self {
        case .error(let message):
            return message
        }
    }
}

enum APIState {
    case loading
    case success
    case failure(APIError)
}

extension Sequence {
    func max<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.max(by: { predicate($0) < predicate($1) })
    }
    func min<T: Comparable>(_ predicate: (Element) -> T)  -> Element? {
        self.min(by: { predicate($0) < predicate($1) })
    }
}

enum MusicType: String{
    case Song = "Song"
    case Album = "Album"
    case all = "ALL"
}

struct MusicModel: Equatable, Codable, Hashable {
    var idCode : String = ""
    var MusicTitle : String = ""
    var MusicBanner: String = ""
    var ArtistName: String = ""
    var id = UUID().uuidString
}


//Local UserDefault data saving
class MusicSessionManager {
    // MARK:- Properties
    
    public static var shared = MusicSessionManager()
    
    //Last album listened to
    var MusicAlbumManager: [MusicModel]{
        get {
            guard let data = UserDefaults.standard.data(forKey: "Music4") else { return [MusicModel(idCode: "Z607ZOD9", MusicTitle: "Hay Là Trăng Nói", MusicBanner: "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/b/6/1/0/b610acff4897820234db16669ef4adcf.jpg", ArtistName: "DatKaa, QT Beatz")] }
            return (try? JSONDecoder().decode([MusicModel].self, from: data)) ?? [MusicModel(idCode: "Z607ZOD9", MusicTitle: "Hay Là Trăng Nói", MusicBanner: "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/b/6/1/0/b610acff4897820234db16669ef4adcf.jpg", ArtistName: "DatKaa, QT Beatz")]
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: "Music4")
        }
    }
    // Las song listened to
    var MusicTabManger: MusicModel {
        get {
            guard let data = UserDefaults.standard.data(forKey: "MusicListStart4") else { return MusicModel(idCode: "Z607ZOD9", MusicTitle: "Hay Là Trăng Nói", MusicBanner: "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/b/6/1/0/b610acff4897820234db16669ef4adcf.jpg", ArtistName: "DatKaa, QT Beatz") }
            return (try? JSONDecoder().decode(MusicModel.self, from: data)) ?? MusicModel(idCode: "Z607ZOD9", MusicTitle: "Hay Là Trăng Nói", MusicBanner: "https://photo-resize-zmp3.zmdcdn.me/w240_r1x1_jpeg/cover/b/6/1/0/b610acff4897820234db16669ef4adcf.jpg", ArtistName: "DatKaa, QT Beatz")
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            UserDefaults.standard.set(data, forKey: "MusicListStart4")
        }
    }
    
    func refresh() {
        
    }
    
    // MARK:- Init
    private init(){
        
    }
}

