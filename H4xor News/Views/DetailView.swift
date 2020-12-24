//
//  DetailView.swift
//  H4xor News
//
//  Created by Aimee Arost on 12/23/20.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "http://www.google.com")
    }
}


