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
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct KimusicApp: App {

    @StateObject private var views = TopLevelController()
    
    var body: some Scene {
        
        WindowGroup {
                MainScreen()
                    .overlay(SplashScreen())
                    .environmentObject(views)
                    .environment(\.colorScheme, .dark)

            
        }
    }
}

