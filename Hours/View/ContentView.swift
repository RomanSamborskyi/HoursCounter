//
//  ContentView.swift
//  Hours
//
//  Created by Roman Samborskyi on 16.08.2023.
//

import SwiftUI

enum Tabs {
    case monts, profile
}

struct ContentView: View {
    
    @State private var selection :Tabs = .monts
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                MonthsView()
                    .tag(Tabs.monts)
                    .tabItem{
                        VStack {
                            Image(systemName: "calendar")
                            Text("Months")
                        }
                    }
                ProfileView()
                    .tag(Tabs.profile)
                    .tabItem{
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                    }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
