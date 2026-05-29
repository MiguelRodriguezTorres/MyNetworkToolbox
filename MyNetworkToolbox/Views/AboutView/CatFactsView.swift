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
                .task { // use task view modifier for async task
                    print(try! await catFactsViewModel.getCatFact())
                    
                    let gatoFact = try! await catFactsViewModel.getCatFact()
                    catFact = gatoFact.fact
                }
//            Button(action: {
//                Task {
//                    print(try await catFactsViewModel.getCatFact())
//                }
//            }, label: {
//                Text("Button")
//            })
            Spacer()
        }
        .padding(.leading, 15)
        .navigationTitle(Text("Cat Facts!"))
    }
}

#Preview {
    CatFactsView()
}
