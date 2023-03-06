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
import Firebase
import FirebaseAuth
struct HomeViews: View {
    
    //Big view where other view shows from
    @EnvironmentObject var viewmodle : TopLevelController

    @Namespace var animation
    @State private var currentPage = 0
    
    @State var columns : [GridItem] = [
        GridItem(.flexible(), spacing: 12, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil)
    ]
    
    let rows = [
        GridItem(.fixed(50), spacing: 12, alignment: nil),
        GridItem(.fixed(50),spacing: 12, alignment: nil)
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            PagerView(pageCount: viewmodle.Banner.count, currentIndex: $currentPage) {
                
                autoreleasepool {
                    ForEach(viewmodle.Banner, id: \.self) { co in
                        AsyncImage(url: URL(string: co.cover!)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                        
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .aspectRatio(4/3, contentMode: .fit)
            
            CustomSegmentedControl()
            
            CustomMusicScroll(titleView: "Nhạc EDM") {
                ForEach(viewmodle.EDM, id: \.self.encodeID) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnail!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Remix for you") {
                ForEach(viewmodle.Remix, id: \.self.encodeID!) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Chill with you") {
                ForEach(viewmodle.Indie, id: \.self.encodeID!) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Top 100 Việt Nam") {
                ForEach(viewmodle.top100VietNam, id: \.self.encodeID) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Top 100 Nổi bật") {
                ForEach(viewmodle.Top100Special, id: \.self.encodeID) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Vì bạn đã nghe") {
                ForEach(viewmodle.AlreadyListen, id: \.self.encodeID) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
            
            CustomMusicScroll(titleView: "Dành cho Fan") {
                ForEach(viewmodle.ForFan, id: \.self.encodeID) { cosItem in
                    autoreleasepool {
                        SongItemDisplay(idCode: cosItem.encodeID!, thumbnalM: cosItem.thumbnailM!, Title: cosItem.title!)
                    }
                }
            }
                        
        }
        .onAppear{
            Task{
                if !viewmodle.ControllLoadingHome {
                    await viewmodle.executedZing()
                }
            
            }
            

        }
        .padding(.bottom, 100)   
        
    }
    
    // MARK: Custom Segmented Control
    @ViewBuilder
    func CustomSegmentedControl()->some View {
        VStack{
            HStack{
                Button{
                    viewmodle.MusicPage = .Song
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(colors: (viewmodle.MusicPage == .Song ? [
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                            ] : [Color.init(red: 0, green: 0, blue: 0)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: UIScreen.main.bounds.width * 40/100, height: 50)
                        Text("Song")
                        .fontWeight(.semibold)
                        .foregroundColor(viewmodle.MusicPage == .Song ? .black : .white)
                        .opacity(viewmodle.MusicPage == .Song ? 1 : 0.7)
                    }
                }
                Button{
                    viewmodle.MusicPage = .Album
                }label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 25)
                            .fill(LinearGradient(colors: (viewmodle.MusicPage == .Album ? [
                                    Color("Gradient1"),
                                    Color("Gradient2"),
                                    Color("Gradient3"),
                            ] : [Color.init(red: 0, green: 0, blue: 0)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: UIScreen.main.bounds.width * 40/100, height: 50)
                        Text("Album")
                        .fontWeight(.semibold)
                        .foregroundColor(viewmodle.MusicPage == .Album ? .black : .white)
                        .opacity(viewmodle.MusicPage == .Album ? 1 : 0.7)
                    }
                }
            }
            if (viewmodle.MusicPage == .Song){
                SongMusic
            }
            else {
                AlbumMusic
            }
        }
    }
    
}

struct HomeViews_Previews: PreviewProvider {
    static var previews: some View {
        HomeViews()
    }
}
//Homeview album and songs displays
extension HomeViews {
    
    private func SongItemDisplay(idCode: String, thumbnalM: String, Title: String) -> some View {
        NavigationLink(destination: StikyHeader(idCode: idCode)) {
            LazyVStack{
                AsyncImage(url: URL(string: thumbnalM)) { image in
                    image.resizable().cornerRadius(20).scaledToFill().clipped().frame(width: 200, height: 200, alignment: .leading)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                
                Text(Title)
                    .bold()
                    .font(.subheadline)
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
            }
        }.buttonStyle(PlainButtonStyle())
    }
    
    private var SongMusic: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                autoreleasepool {
                    ForEach(viewmodle.SongNews.prefix(20), id: \.self.encodeID) { cosItem in
                        LazyVStack{
                            AsyncImage(url: URL(string: cosItem.thumbnailM!)) { image in
                                image.resizable().cornerRadius(10).scaledToFill().clipped().frame(width: 200, height: 200, alignment: .leading)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)

                            Text(cosItem.title!)
                                .bold()
                                .font(.subheadline)
                                .scaledToFit()
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)

                        }.onTapGesture{
                            Task{
                                viewmodle.ShowDynmic = true

                                await viewmodle.updateMusicValueMusicOnly(MusicData: MusicModel(idCode: cosItem.encodeID!, MusicTitle: cosItem.title!, MusicBanner: cosItem.thumbnailM!, ArtistName: cosItem.artistsNames!), TypeMusic: true)
                            }
                        }
                    }
                }
            }
        }
    }

    private var AlbumMusic: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                autoreleasepool {
                    ForEach(viewmodle.Acoustic, id: \.self.encodeID) { co in
                        SongItemDisplay(idCode: co.encodeID!, thumbnalM: co.thumbnailM!, Title: co.title!)
                    }
                }

            }
        }
    }
    
}
