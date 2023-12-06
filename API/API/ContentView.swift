//
//  ContentView.swift
//  API
//
//  Created by Ritwik Singh on 06/12/23.
//

import SwiftUI

struct Quote: Codable, Hashable {
    var quote: String
    var author: String
}

struct ContentView: View {
    
    @State private var quotes = [Quote]()
    
    var body: some View {
        NavigationStack {
            List(quotes, id:\.self) { quote in
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .font(.headline)
                        .foregroundColor(Color("skyBlue"))
                    Text(quote.quote)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Quotes")
            .task {
                await fetchData()
            }
            .refreshable {
                await fetchData()
            }
        }
    }
    
    func fetchData() async {
        //CREATA URL
        guard let url = URL(string: "https://api.breakingbadquotes.xyz/v1/quotes/7") else {
            print("url doesn't work!!")
            return
        }
        
        //FETCH DATA FROM THE URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //DECODE THE DATA
            if let response = try? JSONDecoder().decode([Quote].self, from: data) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    quotes = response
                }
            }
        } catch {
            print("bad new!!!")
        }
        
    }
}

#Preview {
    ContentView()
}
