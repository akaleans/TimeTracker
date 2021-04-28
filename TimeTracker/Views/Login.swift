//
//  Login.swift
//  TimeTracker
//
//  Created by Khalen Stensby on 4/20/21.
//

import SwiftUI

struct TTUser : Codable {
    var email : String
    var password : String
    var clockin : [String]
    var clockout : [String]
}

struct Login: View {
    @State var email: String = ""
    @State var password: String = ""
    @Namespace var animation
    @State var show = false
    @State var invalidPassword = 0
    @State var user = TTUser(email: "", password: "", clockin: [], clockout: [])
    
    var body : some View {
        
        ZStack {
            Color("starkWhite").edgesIgnoringSafeArea(.all)
            VStack {
                // Image
                HomeImage()
                    .padding(.top, 5)
                
                VStack{
                    HStack {
                        VStack(alignment: .leading, spacing: 10){
                            Text("TimeTracker")
                                .font(.system(size: 30, weight: .heavy))
                                .foregroundColor(.primary)
                            Text("Sign in to continue")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                        }
                        Spacer(minLength: 0)
                    }
                    .padding()
                    
                    CustomTextField(image: "envelope", title: "EMAIL", value: $email, animation: animation)
                    CustomTextField(image: "lock", title: "PASSWORD", value: $password, animation: animation)
                        .modifier(ShakeEffect(animatableData: CGFloat(invalidPassword)))
                        
                    HStack {
                        Spacer(minLength: 0)
                        VStack(alignment: .trailing, spacing: 20){
                            Button(action: {
                                login(email : email, password : password)
                                withAnimation(.default){
                                    invalidPassword += 1
                                }
                            }){
                                HStack(spacing: 10){
                                    Text("LOGIN")
                                        .fontWeight(.heavy)
                                    Image(systemName: "arrow.right")
                                        .font(.title)
                                }
                                .foregroundColor(.primary)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 35)
                                .background(LinearGradient(gradient: .init(colors:[.white, .gray]), startPoint: .leading, endPoint: .trailing))
                                .clipShape(Capsule())
                            }
                        }
                        
                    }
                    .padding()
                    .padding(.top, 10)
                }
            }
        }
    }
    func login(email : String, password : String) {
        let requestURL = "http://localhost:8060/tracker/login"
        var request = URLRequest(url: NSURL(string: requestURL)! as URL)
        let ttObj = TTUser(email: email, password: password, clockin: [], clockout: [])
        let jsonData = try! JSONEncoder().encode(ttObj)
        //
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.uploadTask(with: request, from: jsonData) {
            data, response, error in
            if let respData = data {
                let retStr = String(data: respData, encoding: .utf8)
                if retStr == "User is now logged in."{
                    user.email = email
                    user.password = password
                    print(retStr!)
                }
                else if retStr == "Incorrect password."{
                    print(retStr!)
                }
                else{
                    print(retStr!)
                }
                //print("Data returned from server : \(retStr!)")
                //
                //testGetREST()
            } else if let respError = error {
                print("Error returned from request : \(respError)")
            }
        }
        //
        task.resume()
    }

}

struct ShakeEffect : GeometryEffect{
    var travelDistance : CGFloat = 5
    var numShakes : CGFloat = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: travelDistance * sin(animatableData * .pi * numShakes), y: 0))
    }
}
