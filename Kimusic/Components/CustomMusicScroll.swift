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
//Horizontal scrolling for playlist/album views
struct CustomMusicScroll<Content:View> : View {
    
    let Title : String
    let content : Content
    
    init(titleView: String, @ViewBuilder content: () -> Content){
        self.Title = titleView
        self.content = content()
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            Text(Title)
                .font(.title3)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    content
                }
            }
        }
    }
}


struct BlurView: UIViewRepresentable {

    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView{
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
