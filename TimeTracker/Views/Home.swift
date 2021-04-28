//
//  Home.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/20/21.
//

import SwiftUI

struct Home: View {
    
    /*
     TO DO:
     X 1) Make clock in button unclickable after clockin
        a) Save clock in time
        b) Create new clock time above clock out
     X 2) Make clock out button unclickable after clockout
        a) Save clock out time
     3) Add schedule button at bottom
        a) Change view to weekly schedule
     */
    
    @State var lockClockinButton = false
    @State var lockClockoutButton = true
    @State var date = Date()
    
    var body: some View {
        
        ZStack {
            Color("starkWhite").edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20){
                Text("\(dateString(date: date))")
                    .font(.system(size: 30, weight: .heavy))
                Text("\(timeString(date: date))")
                    .font(.system(size: 25, weight: .heavy))
                    .onAppear(perform: {let _ = self.updateTimer})
                Button(action: {
                    lockClockinButton = true
                    lockClockoutButton = false
                }){
                    HStack(spacing: 20){
                        Text("CLOCK IN")
                            .fontWeight(.heavy)
                        Image(systemName: "clock")
                            .font(.title)
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 47)
                    .background(Color.gray)
                    .clipShape(Capsule())
                }
                .disabled(lockClockinButton)
                .opacity(lockClockinButton ? 0.4 : 0.9)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                
                Text("")
                    .font(.system(size: 25, weight: .heavy))
                    .onAppear(perform: {let _ = self.updateTimer})
                
                Button(action: {
                    lockClockoutButton = true
                    lockClockinButton = false
                }){
                    HStack(spacing: 10){
                        Text("CLOCK OUT")
                            .fontWeight(.heavy)
                        Image(systemName: "car")
                            .font(.title)
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 35)
                    .background(Color.gray)
                    .clipShape(Capsule())
                }
                .disabled(lockClockoutButton)
                .opacity(lockClockoutButton ? 0.4 : 0.9)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                
                Text("yes")
                
                Button(action: {
                    // Go to schedule view
                }){
                    HStack(spacing: 10){
                        Text("SCHEDULE")
                            .fontWeight(.heavy)
                        Image(systemName: "calendar")
                            .font(.title)
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 30)
                    .padding(.horizontal, 35)
                    .background(Color.gray)
                    .clipShape(Capsule())
                }
                .opacity(0.9)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
            }
        }
    }
    
    var dateFormat : DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter
    }
    
    var timeFormat : DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return formatter
    }
    
    func timeString(date: Date) -> String {
        let t = timeFormat.string(from: date)
        return t
    }
    
    func dateString(date: Date) -> String {
        let d = dateFormat.string(from: date)
        return d
    }
    
    var updateTimer: Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {_ in
            self.date = Date()
        })
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
