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
        HStack {
            
            HStack(spacing: 5){
                
                //Project Info
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(projectItem.name)
                        .fontWeight(.bold)
                    HStack(){
                        Text(projectItem.description)
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text(String(format: "%.2f", projectItem.hours)+" Hours")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                })
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal)
        }
    }
}
