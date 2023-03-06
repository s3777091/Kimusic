/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Team Falava
 ID: Do Truong An (s3878698) - Le Pham Ngoc Hieu(s3877375) - Nguyen Phuc Cuong (s3881006) - Huynh Dac Tan Dat(3777091)
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement: Fetching API https://fxstudio.dev/fetching-data-to-list-from-api-swiftui-notes-44/ & Mr. Tom Huynh's API code on canvas
 */
import AVKit
import MediaPlayer
import Combine
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct AlbumsDetail {
    var AlbumsTitle : String = ""
    var Description: String = ""
    var like : Int = 0
    var ThumbNail : String = ""
    var ReleaseDate : String = ""
}

final class TopLevelController: ObservableObject{
    
    @Published var ShowDynmic : Bool = false
    
    let ZingClass = ZingCollectorLink();
    @Published var apiState: APIState = .loading
    var cancellables = Set<AnyCancellable>()
    
    //MARK: - For Data Page 1

    @Published var SongNews : [ItemNewMusic] = []
    @Published var EDM : [PlaylistHub] = []
    @Published var Remix : [PlaylistHub] = []
    
    @Published var Indie : [PlaylistHub] = []
    
    @Published var Acoustic : [PlaylistHub] = []
    
    @Published var Banner : [BannerHub] = []
    
    @Published var MusicPage : MusicType = .Song
    @Published var MusicCheck : Bool = true
    
    
    //MARK: - For Data Page
    @Published var AlreadyListen : [ItemItem2] = []
    @Published var ForFan : [ItemItem2] = []
    
    
    @Published var Top100Special : [ItemTop100] = []
    @Published var top100VietNam : [ItemTop100] = []
    
    
    @Published var ControllLoadingHome : Bool = false
    
    

    
    //MARK: Grab all data and Display in Home
    @MainActor
    func executedZing() async {
        let linkPage2 = ZingClass.getHomePage(page: "2")
        
        let linkHomeHub = ZingClass.getHub()
        
        let linktop100 = ZingClass.getTop100()
        
        let linkNewMusic = ZingClass.getNewMusic()
        
        await decoceZingNewMusic(JsonUrl: linkNewMusic)
        
        await decoceZingHUB(JsonUrl: linkHomeHub)
        await decoceZingPage2(JsonUrl: linkPage2)
        await decoceZingTop100(JsonUrl: linktop100)
        
        self.ControllLoadingHome = true
    }
    
    func decoceZingNewMusic(JsonUrl : String) async {
        guard let url = URL(string: JsonUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url) //1
            .subscribe(on: DispatchQueue.global(qos: .background)) //2
            .receive(on: DispatchQueue.main) //3
            .tryMap { (data, response) -> Data in //4
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: NewMusic.self, decoder: JSONDecoder()) //5
            .sink { (completion) in //7
                print("completion: \(completion)")
            } receiveValue: { decoded in
                if(decoded.err == -201) {
                    Task {
                        await self.decoceZingNewMusic(JsonUrl: JsonUrl)
                    }
                } else {
                    Task.detached(priority: .high) {
                        DispatchQueue.main.async {
                            self.SongNews = decoded.data!.items!
                        }
                    }
                }
            }
            .store(in: &cancellables) //8
    }
    
    

    func decoceZingHUB(JsonUrl : String) async {
        guard let url = URL(string: JsonUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url) //1
            .subscribe(on: DispatchQueue.global(qos: .background)) //2
            .receive(on: DispatchQueue.main) //3
            .tryMap { (data, response) -> Data in //4
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ZingHub.self, decoder: JSONDecoder()) //5
            .sink { (completion) in //7
                print("completion: \(completion)")
            } receiveValue: { decoded in
                if(decoded.err == -201) {
                    Task {
                        await self.decoceZingHUB(JsonUrl: JsonUrl)
                    }
                } else {
                    Task.detached(priority: .high) {
                        DispatchQueue.main.async {
                            self.Banner = decoded.data!.banners!
                            
                            for i in 0 ..< (decoded.data!.genre!.endIndex){
                                if (decoded.data!.genre![i].title == "EDM") {
                                    self.EDM = decoded.data!.genre![i].playlists!
                                }
                                
                                if (decoded.data!.genre![i].title == "Remix") {
                                    self.Remix = decoded.data!.genre![i].playlists!
                                }
                                
                                
                                
                                if (decoded.data!.genre![i].title == "Indie") {
                                    self.Indie = decoded.data!.genre![i].playlists!
                                }
                                
                                if (decoded.data!.genre![i].title == "Acoustic") {
                                    self.Acoustic = decoded.data!.genre![i].playlists!
                                }
                            }
                            
                            
                        }
                    }
                }
            }
            .store(in: &cancellables) //8
    }
    //Decode page 2 of homepage
    func decoceZingPage2(JsonUrl : String) async {
        guard let url = URL(string: JsonUrl) else { return }
        

        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: ZingHome2.self, decoder: JSONDecoder())
            .sink { (completion) in
                print("completion: \(completion)")
            } receiveValue: { decoded in
                if(decoded.err == -201) {
                    Task {
                        await self.decoceZingPage2(JsonUrl: JsonUrl)
                    }
                } else {
                    Task.detached(priority: .high) {
                        DispatchQueue.main.async{
                            if (decoded.data!.items != nil){
                                for i in 0..<(decoded.data!.items!.endIndex){
                                    if (decoded.data!.items![i].title == "Dành cho Fan"){
                                        self.ForFan = decoded.data!.items![i].items!
                                        
                                    }
                                    if (decoded.data!.items![i].title == "Nghệ Sĩ Yêu Thích"){
                                        self.AlreadyListen = decoded.data!.items![i].items!
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    //Decode top 100 playlist backup
    func decoceTop100BackupData(JsonUrl : String) async -> Top100? {
        if let url = URL(string: JsonUrl) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(Top100.self, from: data)
                
                if(decoded.err == -201){
                    Task {
                        await decoceTop100BackupData(JsonUrl : JsonUrl)
                    }
                } else {
                    return decoded
                }
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return nil
        
    }
    
    func decoceZingTop100(JsonUrl : String) async {
        guard let url = URL(string: JsonUrl) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url) //1
            .subscribe(on: DispatchQueue.global(qos: .background)) //2
            .receive(on: DispatchQueue.main) //3
            .tryMap { (data, response) -> Data in //4
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Top100.self, decoder: JSONDecoder()) //5
            .sink { (completion) in //7
                print("completion: \(completion)")
            } receiveValue: { decoded in
                if(decoded.err == -201){
                    Task {
                        await self.decoceZingTop100(JsonUrl: JsonUrl)
                    }
                } else {
                    Task.detached(priority: .high) {
                        DispatchQueue.main.async {
                            self.Top100Special = decoded.data![0].items!
                            self.top100VietNam = decoded.data![1].items!
                        }
                    }
                }
            }
            .store(in: &cancellables) //8
    }
    
    @Published var AlbumData : DataClassAlbum?
    
    
    @Published var ListMusic : [Item] = []
    @Published var AlbumStructDetail : AlbumsDetail = AlbumsDetail()
    
    @Published var ArtistDetailList : [ArtistElement] = []
    //MARK: Album Api
    
    //MARK: - For Fetch Api from Albums
    func decoceZingtas(idCode: String) async ->  DataClassAlbum? {
        let linkAlbum = ZingClass.getPlayList(id: idCode)
        
        if let url = URL(string: linkAlbum) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(ZingAlbum.self, from: data)
                
                if(decoded.err == -201){
                    Task{
                        await decoceZingtas(idCode: idCode)
                    }
                } else{
                    return decoded.data!
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return await decoceZingtas(idCode: "6BZDA86U")
    }
    
    
    
    //MARK: - For Executed Albums Data Api from Albums
    @MainActor
    func ExecutedAlbum(idCode: String) async{
        apiState = .loading
        
        AlbumData = await decoceZingtas(idCode: idCode)
        
        ArtistDetailList = AlbumData!.artists!
        ListMusic = AlbumData!.song!.items!
        AlbumStructDetail = AlbumsDetail(
            AlbumsTitle: AlbumData!.title!,
            Description: AlbumData!.sortDescription!,
            like: AlbumData!.like!,
            ThumbNail: AlbumData!.thumbnailM!,
            ReleaseDate: AlbumData!.releaseDate!)
        
        apiState = .success
    }
    
    //MARK: - MusicData
    @Published var MusicLink : String = ""
    @Published var CheckingPlay : Bool = false
    @Published var audioPlayer: AVAudioPlayer?
    @Published var audioTime : Double = 0
    
    @Published var TimeLyric : Int  = 0
    
    
    @Published private(set) var MusicTabBarList: [MusicModel] =  MusicSessionManager.shared.MusicAlbumManager
    
    @Published private(set) var MusicTabBar: MusicModel? = MusicSessionManager.shared.MusicTabManger
    
    //Update music tab bar with album
    func updateMusicValue(MusicData: MusicModel, MusicAlbum: [MusicModel], TypeMusic: Bool) async {
        withAnimation(.easeInOut) {
            DispatchQueue.main.async { [unowned self] in
                MusicTabBar = MusicModel(idCode: MusicData.idCode, MusicTitle: MusicData.MusicTitle, MusicBanner: MusicData.MusicBanner, ArtistName: MusicData.ArtistName)
                
                MusicTabBarList = MusicAlbum
                
                MusicSessionManager.shared.MusicTabManger = MusicModel(idCode: MusicData.idCode, MusicTitle: MusicData.MusicTitle, MusicBanner: MusicData.MusicBanner, ArtistName: MusicData.ArtistName)
                MusicSessionManager.shared.MusicAlbumManager = MusicAlbum
                
            }
            
            Task {
                await executedMusic(TypeControll: TypeMusic)
            }
        }
    }
    //Update music tab bar without album
    func updateMusicValueMusicOnly(MusicData: MusicModel, TypeMusic: Bool) async {
        withAnimation(.easeInOut) {
            DispatchQueue.main.async { [unowned self] in
                MusicTabBar = MusicModel(idCode: MusicData.idCode, MusicTitle: MusicData.MusicTitle, MusicBanner: MusicData.MusicBanner, ArtistName: MusicData.ArtistName)
                
                MusicSessionManager.shared.MusicTabManger = MusicModel(idCode: MusicData.idCode, MusicTitle: MusicData.MusicTitle, MusicBanner: MusicData.MusicBanner, ArtistName: MusicData.ArtistName)
                
            }
            
            Task {
                await executedMusic(TypeControll: TypeMusic)
            }
        }
    }
    
    
    
    @Published var looping: Bool = false
    
    //Function to loop song
    func loop(loop: Bool){
        
        if(loop) {
            audioPlayer?.numberOfLoops = -1
            looping = true
        }
        else {
            audioPlayer?.numberOfLoops = 0
            looping = false
        }
    }
    
    //Play music from link
    @MainActor
    func executedMusic(TypeControll: Bool) async {
        if TypeControll {
            MusicLink = await decoceZingMusicLink(idCode: MusicTabBar!.idCode)!
        } else {
            MusicLink = await decocePodCastLink(idCode: MusicTabBar!.idCode)!
        }
        audioPlayer = await getDataPlayer(sound: MusicLink)
        await decodeLyrick(idMusic: MusicTabBar!.idCode)
        
        
        
        setupRemoteTransportControls()
        setupNowPlaying(audioPlayer: audioPlayer!, MusicName: MusicTabBar!.MusicTitle, MusicImage: LoadImage(Url: MusicTabBar!.MusicBanner)!, MusicArtist: MusicTabBar!.ArtistName)
    }
    
    
    
    
    //MARK: FOR Loading Image
    func LoadImage(Url: String) -> UIImage? {
        let url = URL(string: Url)!
        if let data = try? Data(contentsOf: url){
            return UIImage(data: data)!
        }
        return nil
    }
    
    
    //MARK: For Grab Music Link
    func decoceZingMusicLink(idCode: String) async ->  String? {
        let linkMusic = ZingClass.getMusicPlay(id: idCode)
        
        if let url = URL(string: linkMusic) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(ZingListen.self, from: data)
                
                if(decoded.err == -201){
                    Task {
                        await decoceZingMusicLink(idCode: idCode)
                    }
                }
                else if(decoded.err == -1023){
                    return "error: -1023"
                }
                else{
                    print(decoded)
                    if decoded.data!.the320 ?? "" == "" || decoded.data!.the320 ?? "" == "VIP" {
                        return decoded.data!.the128!
                    } else {
                        return decoded.data!.the320!
                    }
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return "https://mp3-320s1-m-zmp3.zmdcdn.me/d47474980fd9e687bfc8/1167218890150275748?authen=exp=1663663226~acl=/d47474980fd9e687bfc8/*~hmac=f44ab9272206124ee65f05e8aff81f9a"
    }
    
    
    //MARK: For Grab Audio Player
    func getDataPlayer(sound: String) async -> AVAudioPlayer? {
        guard let url = URL(string: sound) else {
            print("Wrong Music Link")
            return nil
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            
            let soundData = try Data(contentsOf: url)
            let audioPlayer = try! AVAudioPlayer(data: soundData)
            
            await UIApplication.shared.beginReceivingRemoteControlEvents()
            
            let commandCenter = MPRemoteCommandCenter.shared()
            commandCenter.nextTrackCommand.isEnabled = true
            
            return audioPlayer
        } catch {
            print("Load Music Fail \(error)")
        }
        return nil
    }
    
    
    
    //MARK: For Play / Pause function
    func play() {
        if audioPlayer!.isPlaying {
            audioPlayer?.pause()
        } else{
            audioPlayer?.play()
        }
        CheckingPlay = audioPlayer!.isPlaying
    }
    
    
    //MARK: For Play / Pause but in Background
    func setupRemoteTransportControls() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if !self.audioPlayer!.isPlaying {
                self.play()
                return .success
            }
            return .commandFailed
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            if self.audioPlayer!.isPlaying {
                self.audioPlayer!.pause()
                return .success
            }
            return .commandFailed
        }
    }
    //MARK: Controll time
    func updateTimer() {
        let currentTime = audioPlayer!.currentTime
        let total = audioPlayer!.duration
        let progress = currentTime / total
        
        withAnimation(.linear(duration: 0.1)) {
            self.audioTime = Double(progress)
        }
        CheckingPlay = audioPlayer!.isPlaying
    }
    //Update progress slider
    func updateSilder(newTime: Double){
        if CheckingPlay == true {
            withAnimation(Animation.linear(duration: 0.1)){
                audioPlayer!.pause()
                audioPlayer!.currentTime = Double(newTime) * audioPlayer!.duration
            }
        }
        
        if CheckingPlay == false {
            withAnimation(Animation.linear(duration: 0.1)){
                audioPlayer?.play()
                CheckingPlay = true
            }
        }
    }
    
    //MARK: Get Current Time
    func getCurrentTime(value: TimeInterval)->String {
        return "\(Int(value / 60)):\(Int(value.truncatingRemainder(dividingBy: 60)) < 9 ? "0" : "")\(Int(value.truncatingRemainder(dividingBy: 60)))"
    }
    
    
    //MARK: Settup BackGround Music
    func setupNowPlaying(audioPlayer: AVAudioPlayer, MusicName: String, MusicImage: UIImage, MusicArtist: String) {
        // Define Now Playing Info
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = MusicName
        
        
        nowPlayingInfo[MPMediaItemPropertyArtwork] =
        MPMediaItemArtwork(boundsSize: MusicImage.size) { size in
            return MusicImage
        }
        
        
        nowPlayingInfo[MPMediaItemPropertyArtist] = MusicArtist
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = audioPlayer.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioPlayer.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = audioPlayer.rate
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    //MARK: Setup BackGround Music in Notification
    func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleInterruption),
                                       name: AVAudioSession.interruptionNotification,
                                       object: nil)
        
        notificationCenter.addObserver(self,
                                       selector: #selector(handleRouteChange),
                                       name: AVAudioSession.routeChangeNotification,
                                       object: nil)
    }
    
    //MARK: Handle music while someone call you
    @objc func handleInterruption(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        if type == .began {
            print("Interruption began")
            // Interruption began, take appropriate actions
        }
        else if type == .ended {
            if let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    // Interruption Ended - playback should resume
                    print("Interruption Ended - playback should resume")
                    play()
                } else {
                    // Interruption Ended - playback should NOT resume
                    print("Interruption Ended - playback should NOT resume")
                }
            }
        }
    }
    
    //MARK: Handle music while you connect headphones
    @objc func handleRouteChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let reasonValue = userInfo[AVAudioSessionRouteChangeReasonKey] as? UInt,
              let reason = AVAudioSession.RouteChangeReason(rawValue:reasonValue) else {
            return
        }
        switch reason {
        case .newDeviceAvailable:
            let session = AVAudioSession.sharedInstance()
            for output in session.currentRoute.outputs where output.portType == AVAudioSession.Port.headphones {
                print("headphones connected")
                DispatchQueue.main.sync {
                    self.play()
                }
                break
            }
        case .oldDeviceUnavailable:
            if let previousRoute =
                userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription {
                for output in previousRoute.outputs where output.portType == AVAudioSession.Port.headphones {
                    print("headphones disconnected")
                    DispatchQueue.main.sync {
                        self.audioPlayer?.pause()
                    }
                    break
                }
            }
        default: ()
        }
    }
    
    //MARK: Show Lyrick Link
    @Published var LyrickMusic : [Sentence] = []
    @Published var ControllLyrickLoading : Bool = false
    
    @MainActor
    func decodeLyrick(idMusic : String) async {
        let linkRick = ZingClass.getLyrick(idMusic: idMusic)
        guard let url = URL(string: linkRick) else { return }
        
        
        URLSession.shared.dataTaskPublisher(for: url) //1
            .subscribe(on: DispatchQueue.global(qos: .background)) //2
            .receive(on: DispatchQueue.main) //3
            .tryMap { (data, response) -> Data in //4
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: LyrickModel.self, decoder: JSONDecoder()) //5
            .sink { (completion) in //7
                print("completion lyrick: \(completion)")
            } receiveValue: { decoded in
                Task.detached(priority: .high) {
                    DispatchQueue.main.async {
                        self.ControllLyrickLoading = true
                        self.LyrickMusic  = decoded.data?.sentences ?? [Sentence.init(words: [Word.init(startTime: 0, endTime: 0, data: "No lyrics")])]
                    }
                }
                
            }
            .store(in: &cancellables) //8
    }
    
    
    
    // MARK: - ALL DATA FOR The PodCast Page
    @Published var  DataAllCast : DataClassPodCast? = nil
    
    @MainActor
    func executedAllPodCast() async {
        let post = ZingClass.getPodCast(page: "1")
        
        DataAllCast = await decocePodCastAllData(JsonUrl: post)
        
        // snap carol
        
        
        // explore podcast
        ExplorePodCast = DataAllCast!.items![2].items!
        
        for i in 0 ..< (DataAllCast!.items!.endIndex - 1) {
            // podcast category
            if (DataAllCast!.items![i].title == "Thể loại podcast"){
                CategoryPodCast = DataAllCast!.items![i].items!
            }
            
            // top podcast
            if (DataAllCast!.items![i].title == "Chương trình nổi bật"){
                TopPodCast = DataAllCast!.items![i].items!
            }
        }
        
        // XONE Radio
        ZingNewsPodCast =  DataAllCast!.items![DataAllCast!.items!.endIndex - 5].items!
        
        // Zing News
        
        ZingNewsPodCast =  DataAllCast!.items![DataAllCast!.items!.endIndex - 4].items!
        
        // Vietcetera
        
        VietceteraPodCast =  DataAllCast!.items![DataAllCast!.items!.endIndex - 3].items!
        
        // On Air
        
        OnAirPodCast = DataAllCast!.items![DataAllCast!.items!.endIndex - 2].items!
        
        // New Program
        NewProgramPodCast = DataAllCast!.items![DataAllCast!.items!.endIndex -  1].items!
        
    }
    
    //Get podcast data from Zing
    func decocePodCastAllData(JsonUrl: String) async -> DataClassPodCast? {
        if let url = URL(string: JsonUrl) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(PodCast.self, from: data)
                if(decoded.err == -201){
                    Task{
                        await decocePodCastAllData(JsonUrl: JsonUrl)
                    }
                } else{
                    return decoded.data
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return await decocePodCastAllData(JsonUrl: JsonUrl)
    }
    
    
    // MARK: - Data for ExplorePodCast in PodCast Section
    @Published var  ExplorePodCast : [PurpleItemPodCast] = []
    
    // MARK: - Data for PodCast Categories in PodCast Section
    @Published var  CategoryPodCast: [PurpleItemPodCast] = []
    
    // MARK: - Data for TopPodCast in the PodCast Page
    @Published var  TopPodCast : [PurpleItemPodCast] = []
    
    // MARK: - DATA for PodCasts that belongs to the XONE Radio
    @Published var  XONEPodCast : [PurpleItemPodCast] = []
    
    // MARK: - DATA for PodCasts that belongs to the ZingNews
    @Published var  ZingNewsPodCast : [PurpleItemPodCast] = []
    
    // MARK: - Data for Vietcetera PodCast
    @Published var  VietceteraPodCast : [PurpleItemPodCast] = []
    
    // MARK: - Data for On Air PodCast
    @Published var  OnAirPodCast : [PurpleItemPodCast] = []
    
    // MARK: - Data for NewProgram PodCast
    @Published var  NewProgramPodCast : [PurpleItemPodCast] = []
    
    
    
    func getTimer()-> Int {
        return audioPlayer?.currentTime.seconds ?? 0
    }
    
    
    // MARK: - Data for Playlist in PodCast
    
    @Published var  EpisodeList : [ItemEpisode] = []
    
    @Published var  titlePodCast : String = ""
    @Published var  bannerPodCast : String = ""
    @Published var  artistName : String = ""
    @Published var artistPhoto : String = ""
    
    @Published var albumDescription : String = ""
    //Grab all episodes from podcast
    @MainActor
    func grabEpisode(id: String, title: String, artistName: String, artistPhoto: String, albumDescription: String) async {
        
        let postEpisode = ZingClass.getEpisodeList(id: id, page: "1")
        
        apiState = .loading
        
        EpisodeList = await decoceEpisodeList(JsonUrl: postEpisode)
        
        apiState = .success
    }
    
    //Get episode list
    func decoceEpisodeList(JsonUrl: String) async -> [ItemEpisode] {
        if let url = URL(string: JsonUrl) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(Episode.self, from: data)
                if(decoded.err == -201){
                    Task{
                        await decoceEpisodeList(JsonUrl: JsonUrl)
                    }
                } else{
                    return decoded.data!.items!
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return []
    }
    
    // MARK: - Data for PodCastList in Category
    
    @Published var  PodCastListCategory : [ItemPodCastListCategory] = []
    
    @Published var  podcastThumbnail : String = ""
    @Published var  podcastTitle : String = ""
    
    @MainActor
    func grabPodCastListCategory(id: String, podcastThumbnail: String, podcastTitle: String) async {
        
        let listcate = ZingClass.getPodCastListCategory(id: id, page: "1")
        
        apiState = .loading
        
        PodCastListCategory = await decocePodCastListCategory(JsonUrl: listcate)
        
        
        apiState = .success
    }
    
    //Get podcast category
    func decocePodCastListCategory(JsonUrl: String) async -> [ItemPodCastListCategory] {
        if let url = URL(string: JsonUrl) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(EpisodePodCastListCategory.self, from: data)
                if(decoded.err == -201){
                    Task{
                        await decocePodCastListCategory(JsonUrl: JsonUrl)
                    }
                } else{
                    return decoded.data!.items!
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return []
    }
    
    
    //MARK: For Grab PodCast Link
    func decocePodCastLink(idCode: String) async ->  String? {
        let linkPodCast = ZingClass.getPodCastPlayer(id: idCode)
        
        if let url = URL(string: linkPodCast) {
            let request = URLRequest(url: url)
            do{
                let (data, response) = try await URLSession.shared.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.error("Link Repose Fail")
                }
                let decoded = try JSONDecoder().decode(PodCastPlayer.self, from: data)
                
                if(decoded.err == -201){
                    Task {
                        await decocePodCastLink(idCode: idCode)
                    }
                } else{
                    
                    if decoded.data!.the128! == "VIP" || decoded.data!.the128! == ""{
                        return decoded.data!.the64!
                    } else {
                        return decoded.data!.the128!
                    }
                }
                
            } catch {
                self.apiState = .failure(APIError.error(error.localizedDescription))
            }
        }
        return "https://mplatform-mcloud-bf-s8.zmdcdn.me/Ud9ET97D1_c/d250edcb988b77d52e9a/66b572c057a7b8f9e1b6/96/source_1487195834_1135070099.m4a?authen=exp=1663663178~acl=/Ud9ET97D1_c/*~hmac=b1fc8e965556ee3c95fce13e95404bdc"
    }
    
    
    
}

