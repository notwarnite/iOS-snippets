//
//  ContentView.swift
//  GeometryEffect
//
//  Created by Ritwik Singh on 07/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isProfileExpanded = false
    @Namespace private var profileAnimation
    @Namespace private var profileName
    @Namespace private var profileAvatar
    @Namespace private var profileJob
    
    var body: some View {
        VStack {
            if isProfileExpanded {
                expandedProfileView
            } else {
                collapsedProfileView
            }
            AnimatedSelector()
        }
    }
    
    var collapsedProfileView: some View {
        HStack {
            profileImage
                .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text("Profile Name")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: profileName, in: profileAnimation)
                
                Text("iOS Developer")
                    .foregroundColor(.secondary)
                    .matchedGeometryEffect(id: profileJob, in: profileAnimation)
            }
        
            
            Spacer()
        }
        .padding()
    }
    
    var expandedProfileView: some View {
        VStack {
            profileImage
                .matchedGeometryEffect(id: profileAvatar, in: profileAnimation)
                .frame(width: 130, height: 130)
            
            VStack {
                Text("Profile Name")
                    .font(.title).bold()
                    .matchedGeometryEffect(id: profileName, in: profileAnimation)
                
                Text("iOS Developer")
                    .foregroundColor(.pink)
                    .matchedGeometryEffect(id: profileJob, in: profileAnimation)
                
                Text("Animated description")
                    .padding()
            }
        }
        .padding()
    }
    
    var profileImage: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .onTapGesture {
                withAnimation(.spring()) {
                    isProfileExpanded.toggle()
                }
            }
    }

}

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
                .padding()
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
    ContentView().preferredColorScheme(.dark)
}
