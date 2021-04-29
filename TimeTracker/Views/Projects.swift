//
//  Projects.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/28/21.
//

import SwiftUI

//struct Project: Identifiable {
//    var id : ObjectIdentifier
//    var name : String
//    var description : String
//    var hoursWorked : Int = 0
//}

struct Projects: View {

    @State var db = connectDB()
    @State var projectList = getProjects()
    @State var searchQuery = ""

    var body: some View {
        
        VStack{
            
            VStack{
                //My projects
                HStack {
                    (
                        Text("Time")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        +
                        Text("Tracker")
                            .foregroundColor(.gray)
                    )
                    .font(.largeTitle)
                    Spacer()
                }
                .padding()
                
                //Search bar
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchQuery)
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.primary.opacity(0.05))
                .cornerRadius(8)
                .padding()
                
                //Divider
                HStack{
                    Text("PROJECTS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.6))
                        .frame(height: 0.5)
                }
                .padding()
                
            }
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    ForEach(projectList, id: \.self) { record in
                        ProjectRow(projectItem: record)
                    }
                }
            })
            .padding(.leading, 10)
            
        }
        
    }
}
