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
    @Binding var currentProject : ProjectItem.ID
    @Binding var currentProjectName : String

    var body: some View {
        
        VStack{
            
            VStack{
                
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
                
                //PROJECTS Divider
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
            
            //Project List
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 15){
                    ForEach(projectList, id: \.self) { record in
                        HStack{
                            
                            //Delete Button
                            Button(action: {
                                deleteProject(in_pid: record.id)
                                projectList.remove(at: getIndex(name: record.name))
                            }, label: {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(Color("red"))
                            })
                            
                            //Project
                            ProjectRow(projectItem: record)
                            
                            //Go to Project Button
                            Button(action: {
                                currentProject = record.id
                                currentProjectName = record.name
                            }, label: {
                                Image(systemName: "arrow.right")
                                    .foregroundColor(Color("orange"))
                                    .padding()
                                    .background(Color("orange").opacity(0.2))
                                    .clipShape(Circle())
                            })
                        }
                    }
                    .onDelete(perform: self.deleteRow)
                }
            })
            .padding(.leading, 10)
            
            //Add Button
            Button(action: {
                currentProject = -2
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(Color("orange"))
                    .padding()
                    .background(Color("orange").opacity(0.2))
                    .clipShape(Circle())
            })
            .padding(.bottom, 15)
        }
    }
    private func getIndex(name: String) -> Int{
        var index = 0
        for i in projectList{
            if name == i.name{
                return index
            }
            index += 1
        }
        return -1
    }
    
    private func deleteRow(at indexSet: IndexSet){
        self.projectList.remove(atOffsets: indexSet)
    }
}

