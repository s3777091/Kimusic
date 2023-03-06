/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Team Falava
 ID: Do Truong An (s3878698) - Le Pham Ngoc Hieu(s3877375) - Nguyen Phuc Cuong (s3881006) - Huynh Dac Tan Dat(3777091)
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement: none
 */


import Foundation

// Zing security hashing
struct ZingStruct{
    let zingVersion : String = "1.7.11"
    
    let ApiKey : String = "X5BM3w8N7MKozC0B85o4KMlzLZKhV00y" // X5BM3w8N7MKozC0B85o4KMlzLZKhV00y
    let secret : String = "acOrvUS15XRW2o9JksiK1KgQ6Vbds8ZW" // acOrvUS15XRW2o9JksiK1KgQ6Vbds8ZW
    
    let domain : String = "https://zingmp3.vn"
    
    
    let Radio : String = "/api/v2/page/get/radio"
    
    let homePage : String = "/api/v2/page/get/home"
    let PlayList : String = "/api/v2/page/get/playlist"
    
    let Listen: String = "/api/v2/song/get/streaming"
    
    let lyrick : String = "/api/v2/lyric/get/lyric"
    
    let SearchResults : String = "/api/v2/search/multi"
    
    let EpisodeList : String = "/api/v2/podcast/episode/get/list"
    
    let PodCastListCategory : String = "/api/v2/podcast/program/get/list-by-cate"
    
    let Top100 : String = "/api/v2/page/get/top-100"
    
    let hashPodCast : String = "/api/v2/podcast/episode/get/streaming"
    
    let hubHome : String = "/api/v2/page/get/hub-home"
    
    let NewMusic : String = "/api/v2/page/get/newrelease-chart"
}


//Hash to link
class ZingCollectorLink {
    
    let zingClass = SecurityHash()
    
    
    func getHomePage(page: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis()) // Ctime
        
        let Hash : String = "ctime=\(timestamp)page=\(page)version=\(ZingStruct().zingVersion)" // 256
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().homePage, Key: ZingStruct().secret) // 512
        let FinalLink = ZingStruct().domain+ZingStruct().homePage+"?page=\(page)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getHomePageUpdate(page: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis()) // Ctime
        
        let Hash : String = "ctime=\(timestamp)page=\(page)version=\(ZingStruct().zingVersion)" // 256
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().homePage, Key: ZingStruct().secret) // 512
        let FinalLink = ZingStruct().domain+ZingStruct().homePage+"?page=\(page)&count=30&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getPlayList(id: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(id)version=\(ZingStruct().zingVersion)" // 256
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().PlayList, Key: ZingStruct().secret) // 512
        
        
        let FinalLink = ZingStruct().domain+ZingStruct().PlayList+"?id=\(id)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getMusicPlay(id: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(id)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().Listen, Key: ZingStruct().secret)
        let FinalLink = ZingStruct().domain+ZingStruct().Listen+"?id=\(id)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getLyrick(idMusic: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(idMusic)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().lyrick, Key: ZingStruct().secret)
        let FinalLink = ZingStruct().domain+ZingStruct().lyrick+"?id=\(idMusic)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getSearchResults(SearchRes: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().SearchResults, Key: ZingStruct().secret)
        let FinalLink = ZingStruct().domain+ZingStruct().SearchResults+"?q=\(SearchRes)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    // MARK: - Get PodCast
    
    func getPodCast(page: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis()) // Ctime
        
        let Hash : String = "ctime=\(timestamp)page=\(1)version=\(ZingStruct().zingVersion)" // 256
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().Radio, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().Radio+"?page=\(1)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    
    // MARK: - Get Episode Playlist
    
    func getEpisodeList(id: String, page: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(id)page=\(page)version=\(ZingStruct().zingVersion)"
        
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().EpisodeList, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().EpisodeList+"?id=\(id)&page=\(page)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
        
    }
    
    
    // MARK: - Get PodCastList in Category
    
    func getPodCastListCategory(id: String, page: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(id)page=\(page)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().PodCastListCategory, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().PodCastListCategory+"?id=\(id)&page=\(page)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
        
    }
    
    func getTop100() -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().Top100, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().Top100+"?ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getHub() -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().hubHome, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().hubHome+"?ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getNewMusic() -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().NewMusic, Key: ZingStruct().secret) // 512
        
        let FinalLink = ZingStruct().domain+ZingStruct().NewMusic+"?ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
    
    func getPodCastPlayer(id: String) -> String {
        let timestamp : String = String(Date().currentTimeMillis())
        
        let Hash : String = "ctime=\(timestamp)id=\(id)version=\(ZingStruct().zingVersion)"
        
        let Sig : String = zingClass.getFinalHash(hashValue: Hash, Slug: ZingStruct().hashPodCast, Key: ZingStruct().secret)
        let FinalLink = ZingStruct().domain+ZingStruct().hashPodCast+"?id=\(id)&ctime=\(timestamp)&version=\(ZingStruct().zingVersion)&sig=\(Sig)&apiKey=\(ZingStruct().ApiKey)"
        return FinalLink
    }
}

