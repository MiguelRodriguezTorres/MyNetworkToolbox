//
//  CatFactView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/26/26.
//

import SwiftUI

struct CatFactsView: View {
    private var catFactsViewModel = CatFactsViewModel()
    
    @State private var catFact: String = ""
    
    var body: some View {
        VStack {
            Text("Here's a cat fact for you. Did you know...\n\n\(catFact)")
                .frame(maxWidth: .infinity, alignment: .leading)
                .task {
                    do {
                        catFact = try await catFactsViewModel.getCatFact().fact
                    } catch {
                        catFact = "Oh no! A cat fact couldn't be retrieved! 😿 Try again later."
                    }
                }
            Spacer()
            Button(action: {
                Task {
                    do {
                        catFact = try await catFactsViewModel.getCatFact().fact
                    } catch {
                        catFact = "Oh no! A cat fact couldn't be retrieved! 😿 Try again later."
                    }
                }
            }, label: {
                Text("Get another fact!")
            })
            .padding(.top, 10)
            .padding(.bottom, 10)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .foregroundStyle(.white)
            .background(.blue)
            .cornerRadius(20)
            .padding(40)
            HStack {
                Image(systemName: "info.circle")
                    .foregroundStyle(.blue)
                Text("Cat facts provided by https://catfact.ninja")
            }
        }
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .navigationTitle(Text("Cat Facts!"))
    }
}

#Preview {
    CatFactsView()
}
