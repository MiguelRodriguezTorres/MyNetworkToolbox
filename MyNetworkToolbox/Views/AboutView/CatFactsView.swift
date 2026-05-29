//
//  CatFactView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/26/26.
//

import SwiftUI

struct CatFactsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Here's a cat fact for you. Did you know...")
                    .padding(.top, 40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.leading, 15)
            .navigationTitle(Text("Cat Facts!"))
        }
    }
}

#Preview {
    CatFactsView()
}
