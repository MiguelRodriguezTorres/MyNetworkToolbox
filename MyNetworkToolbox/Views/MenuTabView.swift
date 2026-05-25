//
//  ContentView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/21/26.
//

import SwiftUI

struct MenuTabView: View {
    var body: some View {
        TabView {
            NetworkDesignView()
                .tabItem {
                    Label("Network", systemImage: "network")
                }
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        //.tabViewStyle(PageTabViewStyle())
    }
}

#Preview {
    MenuTabView()
}
