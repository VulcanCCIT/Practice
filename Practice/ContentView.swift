//
//  ContentView.swift
//  Practice
//
//  Created by Chuck Condron on 5/2/23.
//

import SwiftUI

struct ContentView: View {
  @State var textString = ""
  @State var isClicked  = true
  @State var isStopped = true
  @State var sysImage = "circle"
  @State var startDate = Date.now
  @State var timeElapsed: Int = 0
  @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  @State var toggleText = "Stop Timer"
  
  var body: some View {
    
    let textString = isClicked ? "Clicked" : "Not Clicked"
    let sysImage = isClicked ? "checkmark.circle" : "circle"
    let clickedColor = isClicked ? Color(.red) : Color(.blue)
    
    VStack {
      Image(systemName: sysImage)
        .resizable()
        .frame(width: 50.0, height: 50.0)
        .foregroundColor(clickedColor)
      Text(textString)
        .foregroundColor(clickedColor)
        .font(.title)
        .fontWeight(.bold)
      
      Toggle(isOn: $isClicked) {
          Label("Click Me", systemImage: sysImage)
          .foregroundColor(.white)
      }
      .font(.title)
      .fontWeight(.bold)
      .toggleStyle(.button)
      .foregroundColor(.white)
      .background(Color.blue)
      .fontWeight(.bold)
      .clipShape(Rectangle())
      .cornerRadius(40)
      
      Text(textString)
        .foregroundColor(clickedColor)
        .font(.title)
        .fontWeight(.bold)
      
      Toggle("Or Click Me", isOn: $isClicked)
        .frame(width: 210.0, height: 30.0)
        .foregroundColor(.green)
        .font(.title)
        .fontWeight(.bold)
      
      Text(textString)
        .font(.title)
        .fontWeight(.bold)
        .foregroundColor(clickedColor)
      
      Button(action: {
        IsClicked()
      }, label: {
        Text("Click Me Too!")
          .padding()
          .foregroundColor(.white)
          .background(Color.blue)
          .font(.title)
          .fontWeight(.bold)
          .cornerRadius(20)
      })

      let color = isStopped ? Color(.red) : Color(.blue)
      
      Toggle(toggleText, isOn: $isStopped)
        .frame(width: 250.0, height: 30.0)
        .foregroundColor(color)
        .font(.title)
        .fontWeight(.bold)
        .onChange(of: isStopped) { newValue in
          if newValue {
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            toggleText = "Stop Timer"
          } else {
            toggleText = "Start Timer"
            timeElapsed = 0
            timer.upstream.connect().cancel()
          }
        }
        .padding()
      Divider()
        .frame(width: 300, height: 5)
        .overlay(Color.green)
      HStack {
        Text("TIME ELAPSED: ")
          .foregroundColor(.green)
        Text("\(timeElapsed) Seconds")
          .foregroundColor(.red)
      }
      .font(.title2)
      .fontWeight(.bold)
      .onReceive(timer) { firedDate in
        print("timer fired")
        timeElapsed += 1
        IsClicked()
      }
      .padding()
    }
  }
  
  func IsClicked() {
    if (isClicked) {
      isClicked = false
    } else {
      isClicked = true
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
