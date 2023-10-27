////
////  LoginView.swift
////  Household Organizer
////
////  Created by Andrew Acton on 9/21/23.
////
//
//import SwiftUI
//
//struct LoginView: View {
//    // MARK: - Properties
//    @EnvironmentObject var auth: AuthenticationModel
//    @State private var showCreateNewUser: Bool = false
//    @State private var loginError: String = ""
//    
//    // MARK: - Body
//    var body: some View {
//        ZStack {
//            VStack {
//
//                LoginImageView()
//                
//                Spacer()
//                
//                Text(loginError)
//                    .foregroundColor(.red)
//                
//                LoginDetailsView(showCreateNewUser: $showCreateNewUser)
//                
//                Spacer()
//            }
//            .background(backgroundGradient)
//            .blur(radius: showCreateNewUser ? 8.0 : 0, opaque: false)
//            
//            if showCreateNewUser {
//                BlankView()
//                    .onTapGesture {
//                        withAnimation {
//                            showCreateNewUser = false
//                        }
//                    }
//                
//                    CreateUserView(isShowing: $showCreateNewUser)
//            }
//        }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//            .environmentObject(AuthenticationModel())
//    }
//}
