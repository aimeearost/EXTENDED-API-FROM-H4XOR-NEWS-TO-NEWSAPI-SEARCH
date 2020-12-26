//
//  ContentView.swift
//  H4xor News
//
//  Created by Aimee Arost on 12/23/20.
//

import SwiftUI

struct ContentView: View {
    //    to listen to the "published" posts, we are creating an object from network manager class.
    //    The observedobject makes it listen.
    @ObservedObject var networkManager = NetworkManager()
    @State private var textFieldContent: String = ""

    var body: some View {
            NavigationView {
                //            these posts come from the published posts in the Network Manager
                ZStack {
                    Color(red: 0.25, green: 0.25, blue: 0.25, opacity: 0.20)
                           .edgesIgnoringSafeArea(.all)

                    VStack {
                        HStack {
                            Spacer()
                            TextField("search for news", text: $textFieldContent)
                                .border(Color(red: 0.69, green: 0.02, blue: 0.02, opacity: 1.00), width: 1.0)
                                .padding(.leading)
                            Button(action: {
//                                I NEED TO FIGURE OUT HOW TO GET THE SEARCHTERM UPDATED FROM TEXTFIELDCONTENT
//                                URLName().searchTerm = $textFieldContent
                                print($networkManager.useThisURL)
                                print(self.textFieldContent)
                                textFieldContent = ""
                            }) {
                                Text("SEARCH")
                                    .foregroundColor(Color(red: 0.69, green: 0.02, blue: 0.02, opacity: 1.00))
                            }
                            Spacer()
                            .padding(.all)
                        }
                            List(networkManager.posts){ post in
                                NavigationLink(destination: DetailView(url: post.url)) {
                                    HStack {
                                        Text(post.source.name ?? "")
                                            .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.00))
                                            .bold()
                                            + Text(":  ") + Text(post.title)
                                            .foregroundColor(Color(red: 0.69, green: 0.02, blue: 0.02, opacity: 1.00))
                                            .bold()
                                    
                                    }
                                }
                            }
                    }
                    .navigationBarTitle("NEWS")
            }
    }

            //        Every content view has onAppear like viewdidload
            .onAppear {
                
                self.networkManager.fetchData()
        }
        }

    }

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




//
//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola"),
//]

