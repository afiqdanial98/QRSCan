//
//  ContentView.swift
//  QRScan
//
//  Created by Khirzeri on 23/06/2020.
//  Copyright © 2020 Unicorn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted)
            .tabItem {
                Image(systemName: "questionmark.diamond")
                Text("Contacted")
                
                }
            MeView()
                .tabItem {
                    Image(systemName: "trash")
                    Text("Me")
            }
        }
    .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
