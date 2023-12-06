//
//  ContentView.swift
//  Glassmorphism
//
//  Created by Ritwik Singh on 02/12/23.
//

import SwiftUI

struct HomeView: View {
    var columns = [GridItem(.adaptive(minimum: 159), spacing: 16)]
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: ChildView(courseTitle: "SwiftUI for iOS 14")) {
                CourseCard(image: "illustration", title: "SwiftUI for iOS 14", hours: "20 sections - 3 hours", colors: [Color(#colorLiteral(red: 1, green: 0.4509803922, blue: 0.4509803922, alpha: 1)), Color(#colorLiteral(red: 0.2862745098, green: 0.1176470588, blue: 0.7215686275, alpha: 1))], logo: "swift-logo")
            }
        }
        .navigationBarHidden(true)
    }
}

struct CoursesView: View {
    var columns = [GridItem(.adaptive(minimum: 159), spacing: 16)]
    
    var body: some View {
        ScrollView {
            NavigationLink(destination: ChildView(courseTitle: "SwiftUI for iOS 14")) {
                CourseCard(image: "illustration", title: "SwiftUI for iOS 14", hours: "20 sections - 3 hours", colors: [Color(#colorLiteral(red: 1, green: 0.4509803922, blue: 0.4509803922, alpha: 1)), Color(#colorLiteral(red: 0.2862745098, green: 0.1176470588, blue: 0.7215686275, alpha: 1))], logo: "swift-logo")
            }
        }
        .navigationBarHidden(true)
    }
}

struct ContentView: View {
    @State private var tabSelection = 1
    @State private var tappedTwice: Bool = false
    
    @State private var home = UUID()
    @State private var courses = UUID()
    
    var body: some View {
        var handler: Binding<Int> { Binding(
            get: { self.tabSelection },
            set: {
                if $0 == self.tabSelection {
                    // Lands here if user tapped more than once
                    tappedTwice = true
                }
                self.tabSelection = $0
            }
        )}
        
        return TabView(selection: handler) {
            NavigationView {
                HomeView()
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                        guard tappedTwice else { return }
                        home = UUID()
                        tappedTwice = false
                    })
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("Learn Now")
            }
            .tag(1)
            
            NavigationView {
                CoursesView()
                    .onChange(of: tappedTwice, perform: { tappedTwice in
                        guard tappedTwice else { return }
                        home = UUID()
                        tappedTwice = false
                    })
            }
            .tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Courses")
            }
            .tag(2)
        }
    }
}

#Preview {
    ContentView()
}
