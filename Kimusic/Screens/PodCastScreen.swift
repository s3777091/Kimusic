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

struct PodCastScreen: View {
    @EnvironmentObject var viewmodle : TopLevelController
    
    @State var index = 0
    @State var snap: [forSnap] = []
    @State var finishedLoading = false
    
    @ViewBuilder var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Spacer(minLength: 100)
                        // Snap Carousel
                        if(finishedLoading){
                            SnapCarousel(index: $index, items: snap){ view in
                                //adding label and navigation link over SnapCarousel
                                ZStack{
                                    
                                    AsyncImage(url: URL(string: view.item.thumbnailM!)){ image in
                                        image.resizable().cornerRadius(10).scaledToFill().clipped().frame(width: 150, height: 150, alignment: .center)
                                        
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 150, height: 150)
                                    .clipShape(Circle().size(width: 150, height: 150))
                                    .background{
                                        Circle()
                                            .size(width: 150, height: 150)
                                            .stroke(Color.white, lineWidth: 15)
                                            .frame(width: 150, height: 150, alignment: .center)
                                    }
                                    
                                    NavigationLink(destination: EpisodeListView(id: view.item.encodeID!, title: view.item.title!, artistName: view.item.artists![0].name!, artistPhoto: view.item.thumbnail!, albumDescription: view.item.itemDescription!)){
                                        Circle()
                                            .fill(Color.init(red: 0, green: 0, blue: 0, opacity: 0))
                                            .frame(width:50, height: 50)
                                    }
                                    
                                }
                            }
                        }
                        
                        Spacer(minLength: 150)
                        Text("Explore PodCast").bold().font(.system(size: 20)).padding()
                    }
                    
                    /*
                    Spacer()
                        .frame(width: 0.0, height: 150)
                    
                    CustomMusicScroll(titleView: "Explore PodCast") {
                        autoreleasepool {
                            ForEach(viewmodle.ExplorePodCast,id: \.self.encodeID) { pod in
                                PodCastListView(news: pod)
                            } // ForEacH
                        }
                    }
                     
                    */
                    
                    
                    // MARK: - PodCasts Category
                    
                    VStack(alignment: .leading, spacing: 12){
                        Text("PodCast Category").bold().font(.system(size: 20)).padding()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(viewmodle.CategoryPodCast, id: \.self.title!) { cate in
                                    switch cate.title! {
                                        
                                    case "Top Podcast":
                                        TopPodCastView(idControll: "IWZ980AI", cate: cate)
                                        // id4Category = "IWZ980AI"
                                        
                                    case "Phong cách sống":
                                        //id4Category = "IWZ98I0A"
                                        TopPodCastView(idControll: "IWZ98I0A", cate: cate)
                                        
                                    case "Những câu chuyện":
                                        // id4Category = "IWZ98I0B"
                                        TopPodCastView(idControll: "IWZ98I0B", cate: cate)
                                        
                                    case "Kiến thức":
                                        // id4Category = "IWZ9809F"
                                        TopPodCastView(idControll: "IWZ9809F", cate: cate)
                                        
                                    case "Văn hoá & Xã hội":
                                        // id4Category = "IWZ98I09"
                                        TopPodCastView(idControll: "IWZ98I09", cate: cate)
                                        
                                        
                                    case "Âm nhạc":
                                        // id4Category = "IWZ980AO"
                                        TopPodCastView(idControll: "IWZ980AO", cate: cate)
                                        
                                        
                                    case "Nghề nghiệp":
                                        // id4Category = "IWZ980A0"
                                        TopPodCastView(idControll: "IWZ980A0", cate: cate)
                                        
                                        
                                        
                                    default : Text("No category")
                                        
                                    }
                                    
                                } // ForEacH
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        // HScrollView
                    }.padding(.vertical, 15)
                    
                    
                    
                    Spacer()
                    // MARK: - Top PodCasts
                    // ExplorePodCast
                    CustomMusicScroll(titleView: "Top PodCast") {
                        ForEach(viewmodle.TopPodCast,id: \.self.encodeID) { top in
                            autoreleasepool {
                                PodCastListView(news: top)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // MARK: - Zing News
                    CustomMusicScroll(titleView: "Zing News") {
                        ForEach(viewmodle.ZingNewsPodCast,id: \.self.encodeID) { news in
                            autoreleasepool {
                                PodCastListView(news: news)
                            }
                        }
                    }
                    // MARK: - Vietcetera
                    CustomMusicScroll(titleView: "Vietcetera") {
                        ForEach(viewmodle.VietceteraPodCast,id: \.self.encodeID) { news in
                            autoreleasepool {
                                PodCastListView(news: news)
                            }
                        }
                    }
                    
                    // MARK: - Air Now
                    CustomMusicScroll(titleView: "Air Now") {
                        ForEach(viewmodle.OnAirPodCast,id: \.self.encodeID) { news in
                            autoreleasepool {
                                PodCastListView(news: news)
                            }
                        }
                    }
                    
                    
                } // scrollview
            }.onAppear{
                let group = DispatchGroup()
                group.enter()
                DispatchQueue.main.async {
                    Task{
                        await viewmodle.executedAllPodCast()
                    }
                    group.leave()
                }
                group.notify(queue: .main){
                    snap = forSnap.getArr(items: viewmodle.ExplorePodCast)
                    finishedLoading = true
                }
            }
            .padding(.top,20)
            
        } // ZStack
    } // body
}


extension PodCastScreen {
    // func to use data in api that requires id
    private func TopPodCastView(idControll: String, cate: PurpleItemPodCast) -> some View {
        NavigationLink(destination: PodCastListCategoryView(id: idControll, podcastThumbnail: cate.thumbnail!, podcastName: cate.title! )){
            LazyVStack{
                AsyncImage(url: URL(string: cate.thumbnail!)) { image in
                    image.resizable().cornerRadius(10).scaledToFill().clipped().frame(width: 200, height: 200, alignment: .leading)
                } placeholder: {
                    ProgressView()
                }
                
                Text(cate.title!)
                    .bold()
                    .font(.subheadline)
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                
            }
            Spacer(minLength: 155)
        }.buttonStyle(PlainButtonStyle())
    }
    
    // func to use data in api that doesn't requires id
    private func PodCastListView(news: PurpleItemPodCast) -> some View {
        NavigationLink(destination: EpisodeListView(id: news.encodeID!, title: news.title!, artistName: news.artists![0].name!, artistPhoto: news.thumbnail!, albumDescription: news.itemDescription!)){
            
            LazyVStack{
                AsyncImage(url: URL(string: news.thumbnailM!)) { image in
                    image.resizable().cornerRadius(10).scaledToFill().clipped().frame(width: 200, height: 200, alignment: .leading)
                } placeholder: {
                    ProgressView()
                }
                
                Text(news.title!)
                    .bold()
                    .font(.subheadline)
                    .scaledToFit()
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
            } // LazyVStack
        }.buttonStyle(PlainButtonStyle())
    }
    
    
    
}
