//
//  ContentView.swift
//  BPM Finder - SWIFTUI
//
//  Created by Tyler Dakin on 5/31/20.
//  Copyright © 2020 Tyler Dakin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var bpm: Double = 0.0
    @State var lastTime: Double? = nil
    let mainInitTitle = "Beat Buddy"
    @State var title = "Beat Buddy"
    var bpmSum: Double {
        var total: Double = 0
        for num in bpms {
            total += num
        }
        return total
    }
    let leftImage = UIImage(named: "left")?.withRenderingMode(.alwaysTemplate)
    let rightImage = UIImage(named: "right")?.withRenderingMode(.alwaysTemplate)
    let waitImage = UIImage(named: "wait")?.withRenderingMode(.alwaysTemplate)
    @State var currentImage = UIImage(named: "wait")?.withRenderingMode(.alwaysTemplate)

    var bpmCount: Double {
        return Double(bpms.count)
    }
    @State var bpms = [Double]()
    let secondsInMinute: Double = 60
    var body: some View {
        VStack {
            Text("\(title)")
            .font(.system(size: 50))
            .fontWeight(.heavy)
            .foregroundColor(Color(UIColor.label))
            .padding(.all, 50)
            Image(uiImage: currentImage!)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(Color(UIColor.label))
                .padding(.vertical,0)
            Button(action: {
                let timeSent: Double = CACurrentMediaTime()
                if self.lastTime != nil {
                    let difference = timeSent - self.lastTime!
                    let bpm: Double = self.secondsInMinute/difference
                    self.bpms.append(bpm)
                    if self.bpmCount > 15 {
                        self.bpms.removeFirst()
                    }
                    self.bpm = self.bpmSum/self.bpmCount
                    self.title = "\(Int(self.bpm))"
                }
                self.lastTime = timeSent
                if (self.currentImage == self.leftImage) {
                    self.currentImage = self.rightImage
                }
                else {
                    self.currentImage = self.leftImage
                }
            }) {
                Text("Tap to the beat.")
                    .font(.system(size: 18))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.all)
            }
            .background(Color(UIColor.secondarySystemFill))
            .aspectRatio((16.0/9.0), contentMode: .fill)
            .cornerRadius(15)
            .padding(.all, 25)
            
            Button(action: {
                self.lastTime = nil
                self.bpms.removeAll()
                self.title = self.mainInitTitle
                self.currentImage = self.waitImage
            }) {
                Text("Reset")
                    .font(.system(size: 14))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.all)
            }
            .background(Color(UIColor.secondarySystemFill))
            .aspectRatio((16.0/9.0), contentMode: .fill)
            .cornerRadius(15)
            .padding(.all, 25)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
