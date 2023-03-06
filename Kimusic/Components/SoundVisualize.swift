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

//Small animation on minimized dynamic island view

struct SoundVisualize: View {
    
    var body: some View {
        
        
        HStack(spacing: 4) {
            ForEach(0..<4) { i in
                VisualizerBar(maxHeight: 10, minHeight: 5, width: 5)
            }
        }.frame(width: 25, height: 10)
        
    }
    
}

struct VisualizerBar: View {
    @State private var height: CGFloat = 0
    
    let animationSpeed: Double = 0.3
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let width: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: width / 5)
                .frame(width: width, height: height)
                .animation(.easeInOut(duration: animationSpeed), value: height)
                .foregroundColor(.greenPrimary)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: animationSpeed, repeats: true) { _ in
                        height = CGFloat.random(in: minHeight...maxHeight)
                    }
                }
        }
        .frame(height: maxHeight, alignment: .bottom)
    }
    
    
    
    
}

extension Color {
    static var greenPrimary: Color { Color(red: 0.11, green: 0.73, blue: 0.33) }
    static var darkBackground: Color { Color(red: 0.10, green: 0.08, blue: 0.08) }
}
