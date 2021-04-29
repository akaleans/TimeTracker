//
//  ProjectRow.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/28/21.
//

import SwiftUI

struct ProjectRow: View {
    var projectItem : ProjectItem
    
    var body: some View {
        HStack(spacing: 15){
            
            //Project Info
            VStack(alignment: .leading, spacing: 8, content: {
                Text(projectItem.name)
                    .fontWeight(.bold)
                HStack(){
                    Text(projectItem.description)
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "%.0f", projectItem.hours)+" Hours")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //Buttons VID 12:14
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .foregroundColor(Color("orange"))
                    .padding()
                    .background(Color("orange").opacity(0.2))
                    .clipShape(Circle())
            })
        }
        .padding(.horizontal)
    }
}

struct ProjectRow_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
