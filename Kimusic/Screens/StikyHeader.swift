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

//Header that does not scroll with scroll view to give user button to click
struct StikyHeader: View {
    @State var currentType: String = "Songs"
    // MARK: For Smooth Sliding Effect
    @Namespace var animation
    
    @Environment(\.presentationMode) var presentationMode: Binding
    
    @State var headerOffsets: (CGFloat,CGFloat) = (0,0)
    
    let idCode : String
    
    @EnvironmentObject var vmtask : TopLevelController
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0){
                HeaderView()
 
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 25){
                            autoreleasepool {
                                ForEach(vmtask.ListMusic){ cors in
                                    HStack(spacing: 12){
                                        AsyncImage(url: URL(string: cors.thumbnail!)) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 55, height: 55)
                                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(cors.title!)
                                                .foregroundColor(vmtask.MusicTabBar?.MusicTitle == cors.title! ? .green : .white)
                                                .fontWeight(.semibold)
                                            
                                            Label {
                                                Text(cors.artistsNames!)
                                            } icon: {
                                                Image(systemName: "beats.headphones")
                                                    .foregroundColor(.white)
                                            }
                                            .foregroundColor(.gray)
                                            .font(.caption)
                                        }
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        
                                        
                                        Button {
                                        } label: {
                                            Image(systemName: "ellipsis")
                                                .font(.title3)
                                                .foregroundColor(.white)
                                        }
                                        
                                    }.onTapGesture {
                                        var models : [MusicModel] = []
                                        
                                        let musicData = MusicModel(idCode: cors.encodeId!,
                                                                   MusicTitle: cors.title!,
                                                                   MusicBanner: cors.thumbnailM!,
                                                                   ArtistName: cors.artistsNames!)
                                        for item in vmtask.ListMusic {
                                            models.append(MusicModel(idCode: item.encodeId!, MusicTitle: item.title!, MusicBanner: item.thumbnailM!, ArtistName: item.artistsNames!))
                                        }
                                        vmtask.ControllLyrickLoading = false // return defauls
                                        
                                        vmtask.ShowDynmic = true
                                        Task{
                                            await vmtask.updateMusicValue(MusicData: musicData, MusicAlbum: models, TypeMusic: true)
                                        }
                                    }
                            }
        
                            }
                        }
                        .padding()
                    }
                }
                
            }
        }.onAppear{
            fetchdata()
        }
        .overlay(alignment: .topTrailing){
            
            ZStack{
                BlurView(style: .prominent)
                    .clipShape(CustomCorner(corners: .allCorners, radius: 30))
                
                
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    
                    Image(systemName: "arrow.left.circle.fill")
                        .font(.title2)
                        .foregroundColor(.pink)
                }
                
            }
            .frame(width: 55, height: 30)
            .padding(.vertical, 100)
            


        }
    
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity,alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    
    
    // MARK: Header View
    @ViewBuilder
    func HeaderView()->some View{
        GeometryReader{proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            
            AsyncImage(url: URL(string: vmtask.AlbumStructDetail.ThumbNail)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width,height: height > 0 ? height : 0,alignment: .top)
                    .overlay(content: {
                        ZStack(alignment: .bottom) {
                            
                            // Dimming Out the text Content
                            LinearGradient(colors: [
                                .clear,
                                .black.opacity(0.8)
                            ], startPoint: .top, endPoint: .bottom)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                
                                Text("\(vmtask.AlbumStructDetail.Description)")
                                    .font(.callout)
                                    .foregroundColor(.gray)
                                
                                HStack(alignment: .bottom, spacing: 10) {
                                    Text("\(vmtask.AlbumStructDetail.AlbumsTitle)")
                                        .font(.title.bold())
                                    
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.blue)
                                        .background{
                                            Circle()
                                                .fill(.white)
                                                .padding(3)
                                        }
                                }
                                
                                Label {
                                    
                                    Text("\(vmtask.AlbumStructDetail.ReleaseDate)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white.opacity(0.7))
                                } icon: {
                                    Text("\(vmtask.AlbumStructDetail.like)")
                                        .fontWeight(.semibold)
                                }
                                .font(.caption)
                            }
                            .padding(.horizontal)
                            .padding(.bottom,25)
                            .frame(maxWidth: .infinity,alignment: .leading)
                        }
                    })
                    .cornerRadius(15)
                    .offset(y: -minY)
                
            } placeholder: {
                ProgressView()
            }
            
        }
        .frame(height: 250)
    }
    
}

extension StikyHeader{
    private func fetchdata(){
        Task{
            await vmtask.ExecutedAlbum(idCode: idCode)
        }
    }
}

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    // Optional to retrun value from 0
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader{proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0{
                                startValue = value
                            }
                            
                            offset = (value - (returnFromStart ? startValue : 0))
                        }
                }
            }
    }
}

// MARK: Preference Key
struct OffsetKey: PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
