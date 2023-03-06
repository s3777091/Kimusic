/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 3
  Author: Team Falava
  ID: Do Truong An (s3878698) - Le Pham Ngoc Hieu(s3877375) - Nguyen Phuc Cuong (s3881006) - Huynh Dac Tan Dat(3777091)
  Created  date: 17/09/2022
  Last modified: 17/09/2022
  Acknowledgement: Firebase Authentication Documentaiton https://firebase.google.com/docs/auth
*/

import SwiftUI
import Firebase
import FirebaseAuth

class LoginPageModel: ObservableObject {
    
    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    @Published var notLogged: Bool = false
    @Published var remember: Bool = false
    
    @Published var signUpSuccess = false
    
    // Log Status...
    @AppStorage("log_Status") var log_Status: Bool = false
    
    // Login function
    func Login(){
        withAnimation{
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.notLogged = true
                    
                } else {
                    self.notLogged = false
                    self.log_Status = true
                    print("successful Login")

                     currentUser()
                    //If user selected remember me, store login info into userdefault, else clear userdefault
                    if(self.remember){
                        UserDefaults.standard.set(self.email, forKey: "userEmail")
                        UserDefaults.standard.set(self.password, forKey: "userPassword")
                        UserDefaults.standard.set(true, forKey: "rememberMeOn")
                    }
                    else {
                        UserDefaults.standard.set("", forKey: "userEmail")
                        UserDefaults.standard.set("", forKey: "userPassword")
                        UserDefaults.standard.set(false, forKey: "rememberMeOn")
                    }
                }
            }

        }
    }
    //Register function
    func Register() {
        withAnimation{
            
            Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
                        if error != nil{
                            print(error!.localizedDescription)
                            signUpSuccess = false
                            return
                        }
                        let newUser = AppUser(name: email, photoURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Mr._Smiley_Face.svg/1024px-Mr._Smiley_Face.svg.png" , email: email, favorited: [])
                        do {
                            try db.collection("users").document(email).setData(from: newUser)
                        } catch let error {
                            print("Error writing user to database: \(error)")
                        }
                        print("successful signup")
                        signUpSuccess = true


                    }
            
        }
    }
}
