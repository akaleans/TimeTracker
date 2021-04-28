//
//  HomeImage.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/19/21.
//

import SwiftUI

struct HomeImage: View {
    var body: some View {
        Image("home")
            .resizable()
            .scaledToFit()
            .overlay(Rectangle().stroke(Color.gray, lineWidth: 2))
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct HomeImage_Previews: PreviewProvider {
    static var previews: some View {
        HomeImage()
    }
}
