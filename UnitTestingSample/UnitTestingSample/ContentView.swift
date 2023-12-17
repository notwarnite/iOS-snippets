//
//  ContentView.swift
//  UnitTestingSample
//
//  Created by Ritwik Singh on 17/12/23.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject private var vm: UnitTestViewModel
    
    init(isPremium: Bool) {
            _vm = StateObject(wrappedValue: UnitTestViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        VStack {
            Text(vm.isPremium.description)
        }
        .padding()
    }
}

#Preview {
    ContentView(isPremium: true)
}
