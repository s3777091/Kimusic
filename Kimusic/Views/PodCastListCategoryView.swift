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

struct PodCastListCategoryView: View {
    
    //Back Button config
    @Environment(\.presentationMode) var presentationMode: Binding
    
    //Config design for podcast timer
    @State var time = Timer.publish(every: 0.1, on:.current, in: .tracking).autoconnect()
    
    //Data
    @EnvironmentObject var vmtask : TopLevelController
    
    // variables
    var id: String
    var podcastThumbnail : String
    var podcastName: String
    
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        
        ZStack {
            
            VStack {
                
                VStack(alignment: .leading, spacing: 12){
                        
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                ForEach(vmtask.PodCastListCategory,id: \.self.encodeID) { list in
                                    
                                    NavigationLink(destination: EpisodeListView(id: list.encodeID!, title: list.title!, artistName: list.artists![0].name!, artistPhoto: list.thumbnail!, albumDescription: list.itemDescription!)){
                                    HStack {
                                        LazyVStack {
                                            AsyncImage(url: URL(string: list.thumbnail!)) { image in
                                                image.resizable().cornerRadius(10).scaledToFill().clipped().frame(width: 180, height: 180, alignment: .leading)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                                                
                                         } // lazy vstack
    
                                    }
                                } // navigaiton link
                                        
                                }
    

                                   
                                }
                            }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    // HScrollView
                }.padding(.vertical, 15)
                    .onAppear{
                        Task{
                            await vmtask.grabPodCastListCategory(id: id, podcastThumbnail: podcastThumbnail, podcastTitle: podcastName)
                        }
                    }
            
                
            } // big VStack
            
            
        } // big ZStack
        
    }


