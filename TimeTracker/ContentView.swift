//
//  ContentView.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/19/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var currentProject : ProjectItem.ID = -1
    @State var currentProjectName : String = ""
    
    var body : some View {
        if currentProject == -1{
            Projects(currentProject: $currentProject, currentProjectName: $currentProjectName)
        }
        else if currentProject == -2{
            AddProject(currentProject: $currentProject)
        }
        else {
            Tracker(currentProject: $currentProject, currentProjectName: $currentProjectName)
        }
    }
}
