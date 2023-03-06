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
import FirebaseFirestore
import FirebaseFirestoreSwift

//User profile view
struct AlbumScreen: View {
    @FirestoreQuery(collectionPath: "users", predicates: [.where("email", isEqualTo: Auth.auth().currentUser?.email)], decodingFailureStrategy: .ignore) var user: [AppUser]
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    @EnvironmentObject var MusicController : TopLevelController
    
    @State var showModal = false
    
    @Binding var autoLogin: Bool
    @Binding var notLogged: Bool
    
    
    var body: some View {
        
        VStack{

            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                LazyVStack(pinnedViews: [.sectionHeaders]){
                    
                    Spacer(minLength: 100)
                    
                    Divider()
                    
                    HStack{
                        
                        Button(action: {
                            autoLogin = false
                            notLogged = true
                            loginData.log_Status = false
                            loginData.remember = false
                            do {
                                try Auth.auth().signOut()
                            } catch let error {
                                print("Error signing out: \(error)")
                            }
                            
                        }, label: {
                            
                            AsyncImage(url: URL(string: user.first?.photoURL ?? "https://i.pinimg.com/originals/10/b2/f6/10b2f6d95195994fca386842dae53bb2.png")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .cornerRadius(0)
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(6)
                                            .background(Color.blue)
                                            .clipShape(Circle())
                                            .padding(2)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .offset(x: 5, y: 5)
                                        
                                        ,alignment: .bottomTrailing
                                    )
                            } placeholder: {
                                ProgressView()
                            }
                            
                        })
                        
                        VStack{
                            
                            Text(user.first?.email ?? "No name")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    
                    
                    
                    VStack{
                        
                        Text("Nhạc đã thích")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    
                    
                    ZStack {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 4), count: 3)) {
                            autoreleasepool {
                                ForEach(user.first?.favorited ?? [], id: \.self) { co in
                                    GeometryReader { proxy in
                                        let width = proxy.frame(in: .global).width
                                        Button {
                                            Task{
                                                
                                                await MusicController.updateMusicValue(MusicData: co, MusicAlbum: user.first?.favorited ?? [], TypeMusic: MusicController.decoceZingMusicLink(idCode: co.idCode) != "error: -1023" ? true : false)
                                            }
                                        } label: {
                                            AsyncImage(url: URL(string: co.MusicBanner)) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: width, height: 120)
                                                    .cornerRadius(0)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                    }
                                    .frame(height: 120)
                                }
                            }
                            
                        }
                    }
                    
                }
            })
        }
    }
}

struct AlbumScreen_Previews: PreviewProvider {
    static var previews: some View {
        AlbumScreen(autoLogin: .constant(true), notLogged: .constant(true))
    }
}
