//
//  ContentView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/21/26.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
//            Image(systemName: "globe")
//                .font(.title)
//                .foregroundStyle(.tint)
            Form {
                Section {
                    NavigationLink(destination: NetworkDesignView()) {
                        Text("Create a Network")
                    }
                }
            }
            .navigationTitle(Text("My Network Toolbox"))
        }
    }
}

#Preview {
    MenuView()
}
