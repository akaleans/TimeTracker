//
//  Home.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/20/21.
//

import SwiftUI

struct Tracker: View {
    
    @State var timer : Timer? = nil
    @State var lockClockinButton = false
    @State var lockClockoutButton = true
    @State var date = Date()
    @State private var counter : Double = 0.0
    @State var hoursWorked : Double = 0.0
    @Binding var currentProject : ProjectItem.ID
    @Binding var currentProjectName : String
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20){
            //Timely
            HStack{
                (
                    Text("Time")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("ly")
                        .foregroundColor(.gray)
                )
                .font(.largeTitle)
                Spacer()
            }
            .padding()
        
            //TRACKER Divider
            HStack{
                Text("HOUR TRACKER")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Rectangle()
                    .fill(Color.gray.opacity(0.6))
                    .frame(height: 0.5)
            }
            .padding()
            
            //Project Name
            Text("\(currentProjectName)")
                .foregroundColor(Color("orange")).opacity(0.85)
                .font(.title)
            
            Spacer()
            
            //Date and Time
            VStack(alignment: .center, spacing: 10){
                Text("\(dateString(date: date))")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.gray).opacity(0.9)
                Text("\(timeString(date: date))")
                    .font(.system(size: 20, weight: .semibold))
                    .onAppear(perform: {let _ = self.updateTimer})
                    .foregroundColor(.gray).opacity(0.9)
            }
            
            Spacer()
            
            //Clock in/out buttons
            VStack{
                Button(action: {
                    lockClockinButton = true
                    lockClockoutButton = false
                    startTimer()
                }){
                    HStack(spacing: 20){
                        Text("CLOCK IN")
                            .fontWeight(.heavy)
                        Image(systemName: "clock")
                            .font(.title)
                    }
                    .foregroundColor(Color("orange"))
                    .padding(.vertical, 30)
                    .padding(.horizontal, 47)
                    .background(Color("orange").opacity(0.4))
                    .clipShape(Capsule())
                }
                .disabled(lockClockinButton)
                .opacity(lockClockinButton ? 0.4 : 0.9)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                
                Button(action: {
                    lockClockoutButton = true
                    lockClockinButton = false
                    stopTimer()
                    hoursWorked = counter / 3600
                    updateHours(in_pid: currentProject, in_hours: hoursWorked)
                    currentProject = -1
                }){
                    HStack(spacing: 10){
                        Text("CLOCK OUT")
                            .fontWeight(.heavy)
                        Image(systemName: "car")
                            .font(.title)
                    }
                    .foregroundColor(Color("orange"))
                    .padding(.vertical, 30)
                    .padding(.horizontal, 35)
                    .background(Color("orange").opacity(0.4))
                    .clipShape(Capsule())
                }
                .disabled(lockClockoutButton)
                .opacity(lockClockoutButton ? 0.4 : 0.9)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
            }
            
            Spacer()
        }
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { tempTimer in
            self.counter += 1.0
        }
    }
    
    func stopTimer(){
        timer?.invalidate()
        timer = nil
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

