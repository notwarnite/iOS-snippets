//
//  ContentView.swift
//  PagedScrollview
//
//  Created by Ritwik Singh on 30/11/23.
//

import SwiftUI

struct ContentView: View {
    
    private let sampleImages = [ "1", "2", "3", "4"]
    
    var body: some View {
        VStack{
            Spacer()
            Text("Scrollview Target")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            ScrollView(.horizontal) {
                LazyHStack() {
                    ForEach(sampleImages, id:\.self) { img in
                        Image(img)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 450)
                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                            .padding(.horizontal, 20)
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .scaleEffect(phase.isIdentity ? 1 : 0.7)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}

#Preview {
    ContentView()
}
