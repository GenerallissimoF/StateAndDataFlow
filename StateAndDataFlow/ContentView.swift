//
//  ContentView.swift
//  StateAndDataFlow
//
//  Created by brubru on 21.02.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserManager
    @StateObject private var timer = TimeCounter()
   
    var body: some View {
        VStack(spacing: 40) {
            Text("Hi, \(user.name)")
                .font(.largeTitle)
                .offset(x: 0, y: 100)
            Text("\(timer.counter)")
                .font(.largeTitle)
                .offset(x: 0, y: 100)
            Spacer()
            ButtonView(timer: timer)
            LogOutButtonView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
// не успел оптимизировать кнопки
struct ButtonView: View {
    @ObservedObject var timer: TimeCounter
   
    var body: some View {
        
        Button(action: timer.startTimer) {
            Text("\(timer.buttonTitle)")
            
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }

        .frame(width: 200, height: 60)
        .background(Color.red)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4)
        )
    }
  
}
struct LogOutButtonView: View {

    @EnvironmentObject var user: UserManager
   
    var body: some View {
        Button(action: changeView) {
            Text("Log out")
            
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(Color.red)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 4)
        )
        
    }
}

extension LogOutButtonView {
   func changeView() {
        
     user.isRegister = false
}
}
