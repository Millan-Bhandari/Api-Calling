//
//  ContentView.swift
//  Api Calling
//
//  Created by Millan Bhandari on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes = String()
    @State private var text = ""
    var body: some View {
        VStack {
            Text("Absolutely Hilarious Jokes")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .serif))
                Spacer()
            Text(text)
                .padding()
                .onAppear() {
                    getJokes()
                }
            Button("New Joke") {
                jokes.removeAll()
                getJokes()
                text = jokes
            }
            .background(.cyan)
            .accentColor(.blue)
        }
    }
    
    func getJokes() {
        let apiKey = "?rapidapi-key=d87dc96880msh138dad116ed364ep17b762jsnfa65120c7d18"
        let query = "https://jokes-by-api-ninjas.p.rapidapi.com/v1/jokes/\(apiKey)"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                    let contents = json.arrayValue
                    for item in contents {
                        let joke = item["joke"].stringValue
                        jokes.append(joke)
                }
                return
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Joke {
    let id = UUID()
    var joke = String()
}
