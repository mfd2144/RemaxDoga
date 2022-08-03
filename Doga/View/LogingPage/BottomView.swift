//
//  BottomView.swift
//  Doga
//
//  Created by Mehmet fatih DOĞAN on 31.05.2022.
//

import SwiftUI

struct BottomView: View {
    //MARK: - PROPERTIES
    @ObservedObject var keybordResponder = KeyboardResponder()
    @State private var userName: String = "MFD"
    @State private var password: String = "2144Mfd"
    @EnvironmentObject var loginConditon: LogingCondition
    @Binding var showVerificationCaution: Bool
    @Binding var showContactWithSuperviser: Bool
    var authenticationManager = AuthenticationManager()
    //MARK: -FUNCTIONS
    private func login()  {
        guard let user = Users(rawValue: userName) else {return }
        authenticationManager.login(email: user.emailAdress, pass: password) { result in
            switch result{
            case.success(let string):
                if string != nil {
                    showVerificationCaution.toggle()
                } else {
                    loginConditon.user = user
                    loginConditon.isLoging = true
                }
            case .error(let error):
                if let customError = error as? CustomError,customError == CustomError.connectWithDeveloper{
                    showContactWithSuperviser.toggle()
                }
            }
        }
    }
    //MARK: -BODY
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Spacer()
            TextField("Kullanıcı", text: $userName)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.horizontal)
                .padding(.vertical,15)
                .background( RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("lightBlue"), lineWidth: 3)
                )
                .padding(.horizontal)
              
            SecureField("Şifre", text: $password)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .padding(.horizontal)
                .padding(.vertical,15)
                .background( RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("lightBlue"), lineWidth: 3)
                )
                .padding(.horizontal)
            Button {
                login()
                hideKeybord()
            } label: {
                HStack(alignment: .center, spacing: 5) {
                    Spacer()
                    Image("start")
                        .imageModifier()
                        .frame(height:30)
                    Text("Giriş Yap")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.vertical,15)
                .background(Color("lightBlue").cornerRadius(10))
                .padding(.horizontal)
                .layoutPriority(1)
            }
        }
        .padding(.bottom)
        .padding(.bottom,keybordResponder.currentHeight)
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView(showVerificationCaution: .constant(false), showContactWithSuperviser: .constant(false))
    
    
    }
}
