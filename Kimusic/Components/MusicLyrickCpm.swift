/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2022B
 Assessment: Assignment 3
 Author: Huynh Dac Tan Dat(3777091)
 Created  date: 17/09/2022
 Last modified: 17/09/2022
 Acknowledgement: none
 */

import SwiftUI

//Karaoke function
struct MusicLyrickCpm: View {
    
    var MusicDataLyrick : [Sentence]
    
    @State private var timeTouchEnd : Int = 0
    
    @State private var timeController : Int = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @EnvironmentObject var viewmodle : TopLevelController
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollViewReader { pro in
                autoreleasepool{
                    ForEach(MusicDataLyrick, id: \.self) { ly in
                        HStack {
                            ForEach(ly.words!, id: \.self) { ts in
                                Text(ts.data!)
                                    .bold()
                                    .foregroundColor(timeController == (ts.startTime! / 1000) ? Color.greenPrimary : Color.white)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 22)
                        .padding(.vertical, 1.5)
                        .id(ly.words![0].startTime! / 1000)
                    }
                    .onChange(of: timeController) { ts in
                        
                        withAnimation(.spring()) {
                            pro.scrollTo(ts, anchor: .top)
                        }
                    }
                }
            }
        }.onReceive(timer) { _ in
            
            DispatchQueue.main.async {
                timeController = viewmodle.getTimer()
            }
            
        }
        
    }
}


extension View {
    @ViewBuilder
    func setBG()->some View{
        self
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background {
                Color.primary
                    .opacity(0.05)
                    .ignoresSafeArea()
            }
    }
    
    func applyBG()->some View{
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Color("BackGround")
                    .ignoresSafeArea()
            }
    }
}



extension TimeInterval {
    
    var seconds: Int {
        return Int(self.rounded())
    }
    
    var milliseconds: Int {
        return Int(self * 1_000)
    }
}
