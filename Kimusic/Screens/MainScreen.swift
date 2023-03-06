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
import Lottie
import AVKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum ImageFrame: CGFloat {
    case collapse = 30
    case expanded = 250
}

//Default view of app

struct MainScreen: View {

    @State private var expanded: Bool = false
    
    //MARK: - Music Current Tab
    @State var currentTab: Tab = .home
    @State var animatedIcons: [AnimatedIcon] = {
        var tabs: [AnimatedIcon] = []
        for tab in Tab.allCases{
            tabs.append(.init(tabIcon: tab, lottieView: AnimationView(name: tab.rawValue,bundle: .main)))
        }
        return tabs
    }()
    
    
    //MARK: - gestureOffSet
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    
    @State var clickLike : Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @Environment(\.colorScheme) var scheme
    
    //MARK: - Controll MusicData
    @State private var BackMusic : MusicModel = MusicSessionManager.shared.MusicTabManger
    @State private var BackMusicList: [MusicModel] = MusicSessionManager.shared.MusicAlbumManager
    @EnvironmentObject var MusicController : TopLevelController
    @EnvironmentObject var viewmodle : TopLevelController
    
    //MARK: - Design Musci Slider
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var time : Float = 0  
    
    var body: some View {
        ZStack {
            //Music tab bar
            TabView(selection: $currentTab) {
                
                NavigationView {
                    HomeViews()
                        .ignoresSafeArea(.all)
                        .navigationBarHidden(true)
                }.setBG().tag(Tab.home)
                
                NavigationView{
                    PodCastScreen()
//                        .ignoresSafeArea(.all)
                        .navigationBarHidden(true)
                }
                .applyBG()
                .tag(Tab.podCast)
            }
            
            ReactTabMusicBar()
            
        }
        .onReceive(timer) { (_) in
            
            
            if MusicController.CheckingPlay {
                
                
                MusicController.audioPlayer!.updateMeters() // Update Value Change
                
                
                MusicController.CheckingPlay = MusicController.audioPlayer!.isPlaying
                
                
                time = Float(MusicController.audioPlayer!.currentTime / MusicController.audioPlayer!.duration)
                
                
                
            } else{
                MusicController.CheckingPlay = false
            }
        }
        
        
        .overlay{
            if MusicController.ShowDynmic {
                Spacer()
                Small_Bar_Music
                    .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .onAppear{
            Task{
                await viewmodle.executedAllPodCast()
            }
        }
        .statusBar(hidden: true)
        .edgesIgnoringSafeArea(.top)
    }
    
    //Tab pull up pull
    func onChange(){
        DispatchQueue.main.async {
            withAnimation(.easeInOut){
                self.offset = gestureOffset + lastOffset
            }
        }
    }
    //Tab bar menu for navigation
    @ViewBuilder
    func ReactTabMusicBar() -> some View {
        GeometryReader{ proxy in
            
            let height = proxy.frame(in: .global).height
            
            ZStack {
                BlurView(style: .prominent)
                    .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
                
                VStack{
                    TabBar()
                    
                    if self.offset == 0 {
                        //BatterLevel and Time
                        
                    } else{
                        MusicLyrickCpm(MusicDataLyrick: MusicController.LyrickMusic)
                            .environmentObject(MusicController)
                            .onAppear{
                                if !MusicController.ControllLyrickLoading {
                                    Task{
                                        await MusicController.decodeLyrick(idMusic: MusicController.MusicTabBar!.idCode)
                                    }
                                }
                            }
                    }
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .offset(y: height - 100)
            .offset(y: -offset > 0 ? -offset <= (height - 100) ? offset : -(height - 100) : 0)
            .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                withAnimation(.easeInOut) {
                    out = value.translation.height
                    onChange()
                }
            }).onEnded({ value in
                let maxHeight = height - 100
                
                if -offset > maxHeight / 2 {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                        DispatchQueue.main.async {
                            self.offset = -(maxHeight / 3)
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                                self.expanded = true
                            }
                        }
                    }
                } else if -offset > 100 && -offset < maxHeight / 2 { // Full Screen Handle Error Out Screen
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                        DispatchQueue.main.async {
                            self.offset = -(maxHeight / 3)
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                                self.expanded = true
                            }
                        }
                    }
                } else{
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                        DispatchQueue.main.async {
                            self.offset = 0
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                                self.expanded = false
                            }
                            
                        }
                    }
                }
                
                // Storing Last Offset..
                // So that the gesture can contiue from the last position...
                DispatchQueue.main.async {
                    self.lastOffset = offset
                }
            }))
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    //Small icons on tab bar
    @ViewBuilder
    func TabBar()-> some View {
        HStack(spacing: 0){
            ForEach(animatedIcons){ icon in
                
                let tabColor: SwiftUI.Color = currentTab == icon.tabIcon ? (scheme == .dark ? .white : .black) : .gray.opacity(0.6)
                
                ResizableLottieView(lottieView: icon.lottieView,color: tabColor)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // MARK: Updating Current Tab & Playing Animation
                        currentTab = icon.tabIcon
                        icon.lottieView.play { _ in
                            // TODO
                        }
                    }
            }
        }
        .clipShape(CustomCorner(corners: [.topLeft,.topRight], radius: 30))
        .padding(.vertical,10)
        .background {
            Color.clear
        }
    }
    
    
}

extension MainScreen {
    //Dynamic island music view
    private var Small_Bar_Music : some View {
        VStack {
            HStack {
                
                if expanded {
                    Spacer()
                }
                
                
                AsyncImage(url: URL(string: MusicController.MusicTabBar?.MusicBanner ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: expanded ? ImageFrame.expanded.rawValue: ImageFrame.collapse.rawValue, height: expanded ? ImageFrame.expanded.rawValue: ImageFrame.collapse.rawValue)
                        .clipShape(Circle())
                        .padding(10)
                } placeholder: {
                    ProgressView()
                }
                Spacer()
                if !expanded{
                    SoundVisualize()
                        .padding(10)
                        .padding(.vertical, 10)
                }
            }
            
            if expanded {
                VStack(alignment: .center) {
                    Text(MusicController.MusicTabBar?.MusicTitle ?? "")
                        .bold()
                        .font(.subheadline)
                        .scaledToFit()
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                    
                    Text("\(MusicController.MusicTabBar?.ArtistName ?? "")")
                        .opacity(0.5)
                }
                
                .foregroundColor(.white)
                Spacer()
                Large_MusicView()
                Spacer()
            }
            
        }
        .padding(.vertical, 22)
        .frame(maxWidth: .infinity, maxHeight: expanded ? UIScreen.screenHeight / 2 : 60, alignment: .center)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 1.0)) {
                expanded.toggle()
            }
        }
        .background {
            Color.black
        }
        .clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], radius: 30))
    }
    
    // Full dynamic island  view
    private func Large_MusicView() -> some View {
        
        VStack{
            Slider(value: Binding(get: {time}, set: { (newValue) in
                DispatchQueue.global().async {
                    // yada yada something
                    time = newValue
                    // updating player...
                    DispatchQueue.main.sync {
                        // update UI
                        MusicController.updateSilder(newTime: Double(time))
                    }
                    // this will happen only after 'update UI' has finished executing
                }
            }))
            
            HStack(alignment: .center){
                Button(action: {
                    Task {
                        print(Auth.auth().currentUser!.email)
                        let Ref = db.collection("users").document(Auth.auth().currentUser!.email!)
                        var res : AppUser? = nil
                        // Create a query against the collection.
                        Ref.getDocument(as: AppUser.self) { result in
                            
                            switch result {
                            case .success(let user):
                                clickLike.toggle()
                                print("User: \(user.name)")
                                res = user
                                res?.favorited?.append(MusicController.MusicTabBar!)
                                do {
                                    try db.collection("users").document((res?.email)!).setData(from: res)
                                } catch let error {
                                    print("Error writing user to Firestore: \(error)")
                                }
                            case .failure(let error):
                                //                                clickLike.toggle() // for testing UI
                                print("Error decoding User: \(error)")
                            }
                        }
                    }
                    
                }) {
                    Image(systemName: "suit.heart.fill")
                        .foregroundColor(clickLike ? .red : .blue)
                        .font(.title3)
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        if(MusicController.looping){
                            MusicController.loop( loop: false)
                        }
                        else {
                            MusicController.loop(loop: true)
                        }
                    }
                    
                }) {
                    Image(systemName: MusicController.looping ? "arrow.2.circlepath" : "1.circle")
                        .foregroundColor(MusicController.looping ? .white : .green)
                        .font(.title3)
                }
            }
            .padding(.horizontal, 30)
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    Task {
                        let compare = MusicController.MusicTabBar!
                        
                        print(MusicController.MusicTabBar!)
                        print(MusicController.MusicTabBarList)
                        let index = MusicController.MusicTabBarList.firstIndex(where: {$0.MusicTitle == compare.MusicTitle})
                        if (index! != MusicController.MusicTabBarList.startIndex) {
                            print(index!)
                            print(MusicController.MusicTabBarList.startIndex)
                            await MusicController.updateMusicValue(MusicData: MusicController.MusicTabBarList[index! - 1], MusicAlbum: MusicController.MusicTabBarList, TypeMusic: MusicController.decoceZingMusicLink(idCode: MusicController.MusicTabBarList[index! - 1].idCode) != "error: -1023" ? true : false)
                        }
                        MusicController.play()
                    }
                    
                }) {
                    Image(systemName: "backward.fill").font(.title3)
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        MusicController.play()
                    }
                    
                }) {
                    Image(systemName: MusicController.CheckingPlay ? "pause.fill" : "play.fill").font(.title3)
                }
                
                Spacer()
                
                Button(action: {
                    Task {
                        let compare = MusicController.MusicTabBar!
                        
                        let index = MusicController.MusicTabBarList.firstIndex(where: {$0.MusicTitle == compare.MusicTitle})
                        if (index != nil){
                            if (index! != MusicController.MusicTabBarList.endIndex - 1)
                            {
                                print(index!)
                                print(MusicController.MusicTabBarList.endIndex)
                                await MusicController.updateMusicValue(MusicData: MusicController.MusicTabBarList[index! + 1], MusicAlbum: MusicController.MusicTabBarList, TypeMusic: MusicController.decoceZingMusicLink(idCode: MusicController.MusicTabBarList[index! + 1].idCode) != "error: -1023" ? true : false)
                            }
                        }
                        MusicController.play()
                    }
                    
                }) {
                    Image(systemName: "forward.fill").font(.title3)
                }
                Spacer()
                
                
                
            }.foregroundColor(.white)
                .font(.title)
        }
        
    }
    
}