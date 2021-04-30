//
//  AddProject.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/29/21.
//

import SwiftUI

struct AddProject: View {
    
    @Binding var currentProject : ProjectItem.ID
    @Namespace var animation
    @State var name : String = ""
    @State var description : String = ""
    @State var hours : String = "0.0"
    @State var db = connectDB()
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                //Timely
                HStack {
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
                
                //PROJECTS Divider
                HStack{
                    Text("ADD PROJECT")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(height: 0.5)
                }
                .padding()
                Spacer()
                
                //Text Fields
                VStack(alignment: .leading, spacing: 10, content: {
                    CustomTextField(image: "briefcase", title: "NAME", value: $name, animation: animation)
                    CustomTextField(image: "rectangle.and.paperclip", title: "DESCRIPTION", value: $description, animation: animation)
                    CustomTextField(image: "clock", title: "HOURS WORKED", value: $hours, animation: animation)
                })
                .padding(.bottom, 20)
                Spacer()
                
                //Submit Button
                Button(action: {
                    addProject(in_name: name, in_description: description, in_hours: Double(hours)!)
                    currentProject = -1
                }){
                    HStack(spacing: 10){
                        Text("SUBMIT")
                            .fontWeight(.heavy)
                            .foregroundColor(Color("orange"))
                    }
                    .foregroundColor(.primary)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color("orange").opacity(0.2))
                    .clipShape(Capsule())
                }
                .padding(.bottom, 15)
            }
        }
    }
}

