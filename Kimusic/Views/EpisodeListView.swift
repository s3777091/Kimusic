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

struct EpisodeListView: View {
    
    @State var temp = 0
    
    //Back Button config
    @Environment(\.presentationMode) var presentationMode: Binding
    
    //Config design for podcast timer
    @State var time = Timer.publish(every: 0.1, on:.current, in: .tracking).autoconnect()
    
    
    @EnvironmentObject var vmtask : TopLevelController
    
    func returnNothing() {
        temp = 1
    }
    
    var id: String
    var title: String
    var artistName : String
    var artistPhoto : String
    var albumDescription : String
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 10){ // big vstack
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // MARK: - VStack for Intro Section
                    VStack(alignment: .leading, spacing: 10) {
                        
                        // MARK: Title and Care Button
                        HStack {
                            Text(title).font(.system(size: 20)).bold()
                            
                            Spacer(minLength: 5)
                            
                            Button {
                                returnNothing()
                            } label: {
                                Text("QUAN TÂM").foregroundColor(.white).bold().font(.system(size: 13))
                                    .background(
                                        Capsule().frame(width: 100, height: 30, alignment: .center)
                                    )
                            }
                            
                            
                        }
                        
                        Spacer(minLength: 5)
                        
                        // MARK: ArtistPhoto and ArtistName
                        HStack{
                            
                            AsyncImage(url: URL(string: artistPhoto)) { image in
                                image.resizable().frame(width: 25, height: 25, alignment: .center).clipShape(Circle().size(width: 25, height: 25)).background{
                                    Circle().size(width: 25, height: 25).stroke(Color.white, lineWidth: 5)
                                }
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Text(artistName).font(.system(size: 20))
                            
                        }
                        
                        Spacer(minLength: 5)
                        
                        HStack {
                            Text(albumDescription)
                                .lineLimit(3)
                            
                            
                        }
                        
                        Spacer(minLength: 10)
                        
                        
                        // MARK: Number of Episodes in this PodCast
                        
                        HStack {
                            
                            Text("Tất cả các tập (\(vmtask.EpisodeList.count))").bold().font(.system(size: 20))
                            
                            Text("").padding(.horizontal, 93)
                            
                            Image(systemName: "arrow.up.and.down.square").resizable().frame(width: 20, height: 20, alignment: .trailing)
                            
                            
                        }
                    }.padding(.horizontal, 15) // VStack for Intro Section
                    
                    
                    // MARK: - VStack for Episode List Section
                    
                    VStack {
                        
                        ForEach(vmtask.EpisodeList, id: \.self.encodeID) { ts in
                            
                            Divider().overlay(.white)
                            
                            VStack(alignment: .leading, spacing: 10) { // one episode
                                
                                HStack {
                                    
                                    VStack (alignment: .leading, spacing: 6 ){
                                        
                                        AsyncImage(url: URL(string: ts.thumbnail!)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            Color.red
                                        }
                                        .frame(width: 70, height: 70)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        
                                    }
                                    
                                    
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        
                                        Text(ts.title!).bold().lineLimit(2)
                                        
                                        HStack {
                                            
                                            Text(String(Date(timeIntervalSince1970: TimeInterval(Int(ts.releaseDate!))).formatted(.dateTime.day())) + "/")
                                            
                                            Text("0" + String(Date(timeIntervalSince1970: TimeInterval(Int(ts.releaseDate!))).formatted(.dateTime.month())).suffix(1) + "/")
                                            
                                            Text(String(Date(timeIntervalSince1970: TimeInterval(Int(ts.releaseDate!))).formatted(.dateTime.year())))
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                                
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    
                                    HStack {
                                        
                                        Text("\(ts.itemDescription!)").lineLimit(3)
                                        
                                    }
                                    
                                    HStack {
                                        
                                        // play button
                                        Image(systemName: "play.circle")
                                            .foregroundColor(.blue)
                                            .onTapGesture {
                                                Task {
                                                    
                                                    vmtask.ShowDynmic = true
                                                    var episodesModel : [MusicModel] = []
                                                    for ts in vmtask.EpisodeList {
                                                        episodesModel.append(MusicModel(idCode: ts.encodeID!, MusicTitle: ts.title!, MusicBanner: ts.thumbnail!, ArtistName: artistName))
                                                    }
                                                    await vmtask.updateMusicValue(MusicData: MusicModel(idCode: ts.encodeID!, MusicTitle: ts.title!, MusicBanner: ts.thumbnail!, ArtistName: artistName), MusicAlbum: episodesModel, TypeMusic: false)
                                                    
                                                }
                                            }
                                        
                                        
                                        Text("\(ts.duration! / 60)  phút ").foregroundColor(.blue)
                                        
                                        
                                        Text("").padding(.horizontal, 130)
                                        
                                        
                                        
                                        
                                    }
                                    
                                }
                                
                                
                            } // VStack
                        }
                        
                    }.padding().onAppear{
    
                        Task{
                            await vmtask.grabEpisode(id: id, title: title, artistName: artistName, artistPhoto: artistPhoto, albumDescription: albumDescription)
                        }
                    }
                    
                } // Second ForEach
                
            } // VStack
        } // ZStack
    }
}

