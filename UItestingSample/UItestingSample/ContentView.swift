//
//  ContentView.swift
//  UItestingSample
//
//  Created by Ritwik Singh on 18/12/23.
//

import SwiftUI

class UITestingViewModel: ObservableObject {
    let placeholderText: String = "Enter your name..."
    @Published var textFieldText: String = ""
    @Published var currentUserIsSignedin: Bool = false
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedin = true
    }
}

struct ContentView: View {
    @StateObject private var vm = UITestingViewModel()
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            
            ZStack {
                if vm.currentUserIsSignedin {
                    SignedInHomeView()
                }
                
                if !vm.currentUserIsSignedin{
                    signUpLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}

extension ContentView {
    private var signUpLayer: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .accessibilityIdentifier("SignUpTextField")
            
            Button(action: {
                withAnimation(.spring()) {
                    vm.signUpButtonPressed()
                }
            }, label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .accessibilityIdentifier("SignUpButton")

        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State private var showAlert: Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Show Welcome Alert!!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(10)
                        .accessibilityIdentifier("ShowAlertButton")
                })
                .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text("Welcome to the app :)"))
                })
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Navigate")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                )
                .accessibilityIdentifier("NavigationLinkToDestination")
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    ContentView()
}
