//
//  AboutView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/25/26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Text("About My Network Toolbox")
                .fontWeight(.bold)
                .font(.title)
                .padding(.top, 40)
                .padding(.bottom, 20)
                //.frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "person.circle")
                .font(.system(size: 50))
                .padding(.bottom, 20)
                .foregroundColor(.blue)
            Text("This app was developed by Miguel Rodriguez.\n\nThe purpose of this app is to be a collection of small network tools that can help network engineers and technicians in their day to day work.")
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "leaf.fill")
                .padding(.top, 40)
                .font(.system(size: 50))
                .foregroundStyle(.blue)
            Spacer()
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
    }
}

#Preview {
    AboutView()
}
