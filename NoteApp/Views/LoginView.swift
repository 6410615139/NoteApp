//
//  LoginView.swift
//  NoteApp
//
//  Created by Supakrit Nithikethkul on 22/3/2567 BE.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "Note", subtitle: "Keep your things", angle: 15, background: .green)
                
                Form {
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                        .autocapitalization(.none)
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    myButton(title: "Log In", background: .blue) {
                        viewModel.login()
                    }
                }
                VStack {
                    Text("Register")
                    NavigationLink("Create an Account", destination:
                        RegisterView())
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
