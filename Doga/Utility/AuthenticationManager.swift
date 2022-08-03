//
//  AuthenticationManager.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 8.07.2022.
//

import Foundation
import FirebaseAuth

class AuthenticationManager{
    func createUser(email: String, pass: String){
        Auth.auth().createUser(withEmail: email, password: pass) { dataResult, error in
            
        }
    }
    func login(email: String, pass: String,completion: @escaping(Results<String?>) -> () ){
        Auth.auth().signIn(withEmail: email, password: pass) { authResult, error in
            if let error = error{
                completion(.error(error))
            }else{
                if let authResult = authResult {
                    let user = authResult.user
                    if user.isEmailVerified {
                        completion(.success(nil))
                    } else {
                        for userCase in Users.allCases{
                            if userCase.emailAdress == email{
                                user.sendEmailVerification()
                                completion(.success("Email adresinize doğrulama gönderildi"))
                            }
                        }
                    }
                  }
            }
        }
    }
}
