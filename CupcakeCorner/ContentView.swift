//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Sander Haug on 23/01/2023.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) {item in
            VStackLayout(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                
            }
        }.task {
           await loadData()
        }
    }
    
    func loadData() async {
        //1: Create URL we want to read
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            fatalError("Something went wrong with the provided link")
        }
        
        //2: fetch data from said URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
                
            //3: Decode data from URL to response data
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            fatalError("Invalid data.")
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
