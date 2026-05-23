//
//  NetworkDetailsView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/21/26.
//

import SwiftUI

struct GatherNetworkDetailsView: View {
    @State private var cidr: Cidr = .zero
    @State private var prefixOne: String = ""
    @State private var prefixTwo: String = ""
    @State private var prefixThree: String = ""
    
    @State private var isShowingNetworkDetailsSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Network Address: \(checkPrefixEmpty(prefixOne)).\(checkPrefixEmpty(prefixTwo)).\(checkPrefixEmpty(prefixThree)).0/\(cidr.rawValue)")) {
                    TextField("First Prefix", text: $prefixOne)
                        .keyboardType(.numberPad)
                    TextField("Second Perfix", text: $prefixTwo)
                        .keyboardType(.numberPad)
                    TextField("Third Prefix", text: $prefixThree)
                        .keyboardType(.numberPad)
                    Text("Fourth Prefix: 0")
                    Picker("CIDR", selection: $cidr) {
                        ForEach(Cidr.allCases, id: \.self) { cidrOption in
                            Text("/\(String(cidrOption.rawValue))")
                        }
                    }
                }
                Section {
                    Button("Calculate Pool") {
                        // open NetworkDetailsView in a sheet
                        isShowingNetworkDetailsSheet = true
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(Text("Network Design"))
            .sheet(isPresented: $isShowingNetworkDetailsSheet) {
                //NetworkDetailsView(prefixOne: calculatedPrefixOne, prefixTwo: calculatedPrefixTwo, prefixThree: calculatedPrefixThree, cidr: cidr.rawValue)
                NetworkDetailsView(isPresented: isShowingNetworkDetailsSheet, prefixOne: convertPrefixToInt(checkPrefixEmpty(prefixOne)), prefixTwo: convertPrefixToInt(checkPrefixEmpty(prefixTwo)), prefixThree: convertPrefixToInt(checkPrefixEmpty(prefixThree)), cidr: cidr.rawValue)
            }
        }
    }
    
    // check if prefix is an empty string value
    private func checkPrefixEmpty(_ prefix: String) -> String {
        return prefix.isEmpty ? "0" : prefix
    }
    
    // convert String prefix to Int
    private func convertPrefixToInt(_ prefix: String) -> Int {
        guard let prefixInt = Int(prefix) else {
            return 0
        }
        
        return prefixInt
    }
}

#Preview {
    GatherNetworkDetailsView()
}
