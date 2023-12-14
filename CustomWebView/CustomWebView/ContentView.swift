//
//  ContentView.swift
//  CustomWebView
//
//  Created by Ritwik Singh on 14/12/23.
//

import SwiftUI
import UIKit
import WebKit

struct CustomWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let wkwebView = WKWebView()
        let req = URLRequest(url: url)
        wkwebView.load(req)
        return wkwebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}


struct ContentView: View {
    let url: String = "https://www.apple.com"
    var body: some View {
            CustomWebView(url: URL(string: url)!)
                .edgesIgnoringSafeArea(.bottom)

    }
}

#Preview {
    ContentView()
}
