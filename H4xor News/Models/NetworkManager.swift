//
//  NetworkManager.swift
//  H4xor News
//
//  Created by Aimee Arost on 12/23/20.
//

import Foundation

//This is decoding the data in the PostData file
//How do we show results on the screen? In order to pass results from Network Managre to the list inside the content view, simplest way is to make NetworkManager conform to protocol called ObservableObject. This enables it to broadcast or "publish" one or many of its properties. Other objects can "subscribe" to the NetworkManager and listen for changes in those properties (the posts) to update its views accordingly.
class NetworkManager: ObservableObject {
    
    //    this published is kind of like subscribing to an RSS feed so you hear from it when content changes
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://newsapi.org/v2/everything?q=basketball&apiKey=8e28babb2a8e4a4a91a9890b14ee915a") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let data = data {
                        //                        try is added because decoder.decode can "throw" and then wrap in a do-catch block
                        do {
                            //                            once decoded, we will bind it to a let constant; results can then be used to populate lists
                            let results = try decoder.decode(Results.self, from: data)
                            
                            DispatchQueue.main.async {
                                //                            This now has all of the posts/hits objects so next need to publish posts to any interested parties, which we do using the property wrapper @Published = up above in the var posts.
                                self.posts = results.articles
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            //            outside of task closure, we need to start it - this starts the networking task
            task.resume()
        }
    }
}
