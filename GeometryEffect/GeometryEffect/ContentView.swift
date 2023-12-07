//
//  ContentView.swift
//  GeometryEffect
//
//  Created by Ritwik Singh on 07/12/23.
//

import SwiftUI

struct AnimatedSelector: View {
    
    let categories: [String] = ["Home", "Movies", "Shows"]
    @State private var selected: String = ""
    @Namespace private var namespace
    
    var body: some View {
        HStack{
            ForEach(categories, id:\.self) { category in
                ZStack{
                    if selected == category {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.brown.opacity(0.5))
                            .matchedGeometryEffect(id: "cat-select", in: namespace)
                    }
                    
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .onTapGesture {
                    withAnimation {
                        selected = category
                    }
                }
            }
        }
    }
    
}


#Preview {
    AnimatedSelector()
}
