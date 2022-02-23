//
//  RegisterView.swift
//  StateAndDataFlow
//
//  Created by brubru on 21.02.2022.
//

import SwiftUI

class Name: ObservableObject {
    @Published var nameOfUser = ""
}

struct RegisterView: View {
    
    @EnvironmentObject var user: UserManager
    @StateObject private var name = Name()
    @State private var textColor: Color = .red
    @State var disabledButton = true
    
    @AppStorage("name") var nameForSave = ""
    
    
    var body: some View {
        VStack {
            HStack {
            TextField("Enter your name...", text: $name.nameOfUser, onEditingChanged: { _ in
                name.nameOfUser = nameForSave
            })
                .onReceive(self.name.$nameOfUser) { _ in
                    checkName()
            }
                .multilineTextAlignment(.center)
                .foregroundColor(textColor)
            Text( String(name.nameOfUser.count))
                    .offset(x: -50, y: 0)
                    .foregroundColor(textColor)
            }
            
            Button(action: registerUser) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Ok")
                }
            }
            .disabled(disabledButton)
        }
    }
}

extension RegisterView {
    private func registerUser() {
        if !name.nameOfUser.isEmpty && name.nameOfUser.count > 3 {
            user.name = name.nameOfUser
            user.isRegister.toggle()
        }
    }
    
    private func checkName() {
        if name.nameOfUser.count > 3 {
            disabledButton = false
            textColor = .green
          
        } else {
            textColor = .red
            disabledButton = true
        }
        }
    }



struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
