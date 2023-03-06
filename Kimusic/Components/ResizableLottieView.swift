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
import Lottie


// MARK: Animated Icon Model
struct AnimatedIcon: Identifiable{
    var id: String = UUID().uuidString
    var tabIcon: Tab
    var lottieView: AnimationView
}


// MARK: Enum For Tabs with Rawvalue as Asset Image
enum Tab: String,CaseIterable{
    case home = "Home"
    case podCast = "PodCast"
}

// MARK: Resizable Lottie View
struct ResizableLottieView: UIViewRepresentable {
    var lottieView: AnimationView
    var color: SwiftUI.Color = .black
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        addLottieView(to: view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // MARK: Dynamic Color Update
        if let animationView = uiView.subviews.first(where: { view in
            view is AnimationView
        }) as? AnimationView{
            // MARK: Finding Keypaths With the Help of Log

            let lottieColor = ColorValueProvider(UIColor(color).lottieColorValue)
            // MARK: Fill Key Path
            let fillKeyPath = AnimationKeypath(keys: ["**","Fill 1","**","Color"])
            animationView.setValueProvider(lottieColor, keypath: fillKeyPath)
            
            // MARK: Stroke Key Path
            let strokeKeyPath = AnimationKeypath(keys: ["**","Stroke 1","**","Color"])
            animationView.setValueProvider(lottieColor, keypath: strokeKeyPath)
        }
    }
    
    func addLottieView(to: UIView){
        // MARK: Memory Properties
        lottieView.backgroundBehavior = .forceFinish
        lottieView.shouldRasterizeWhenIdle = true
        
        lottieView.backgroundColor = .clear
        lottieView.contentMode = .scaleAspectFit
        
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            lottieView.widthAnchor.constraint(equalTo: to.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: to.heightAnchor)
        ]
        
        to.addSubview(lottieView)
        to.addConstraints(constraints)
    }
}
