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
    @State  var textFieldContent: String = ""

    
    
    var body: some View {
            NavigationView {
                //            these posts come from the published posts in the Network Manager
                ZStack {

                    VStack {
                        HStack {
                            TextField("search", text: $textFieldContent)
                                .border(Color(red: 0.50, green: 0.67, blue: 0.48, opacity: 0.00))
//                                .padding(.leading)
                                .frame(width: 200)
                                .multilineTextAlignment(.center)
//                                .font(Font.system(size: 15, weight: .medium, design: .serif))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(10)
                                  .font(Font.system(size: 15, weight: .medium, design: .serif))
                                  .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.50, green: 0.67, blue: 0.48, opacity: 1.00), lineWidth: 1))
                            ZStack {
                                

                                
                                Button(action: {
                                    networkManager.fetchSearch(searchTerm: textFieldContent)
                                    
                                    
                                    networkManager.useThisURL = "\(URLName().partialURL)\(textFieldContent)\(URLName().apiKey)"
                                    
                                    networkManager.fetchData()
                                    
                                    print(networkManager.useThisURL)
                                    
                                    textFieldContent = ""
                                    UIApplication.shared.endEditing()

                                }) {
                                    Text("")
                                        .foregroundColor(Color(red: 0.50, green: 0.67, blue: 0.48, opacity: 1.00))
                                        .font(Font.system(size: 20))
                                    Image(systemName: "magnifyingglass.circle.fill")
                                        .foregroundColor(Color(red: 0.50, green: 0.67, blue: 0.48, opacity: 1.00))
                                        .font(.largeTitle)

                                        .aspectRatio(contentMode: .fit)

                                }
                            }
                            .padding(.all)
                            
                        }
                            List(networkManager.posts){ post in
                                NavigationLink(destination: DetailView(url: post.url)) {
                                    HStack {
                                        Text(post.source.name ?? "")
//                                            .foregroundColor(Color(red: 0.15, green: 0.15, blue: 0.15, opacity: 1.00))
                                            .bold()
                                            + Text(":  ") + Text(post.title)
//                                            .foregroundColor(Color(red: 0.69, green: 0.02, blue: 0.02, opacity: 1.00))
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
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



//
//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Bonjour"),
//    Post(id: "3", title: "Hola"),
//]

