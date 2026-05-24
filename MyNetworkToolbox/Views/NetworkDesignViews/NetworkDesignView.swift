//
//  NetworkDetailsView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/21/26.
//

import SwiftUI

struct NetworkDesignView: View {
    @State private var cidr: Cidr = .thirtyTwo
    @State private var prefixOne: String = ""
    @State private var prefixTwo: String = ""
    @State private var prefixThree: String = ""
    
    @State private var isShowingNetworkDetailsSheet: Bool = false
    @State private var isShowingNetworkDesignSettingsSheet: Bool = false
    
    @Environment(\.dismiss) private var dismissNetworkDesignSettingsSheet
    
    @FocusState private var isFocused: Bool // dismiss keyboard
    
    @StateObject var networkDesignViewModel = NetworkDesignViewModel()
    
    @AppStorage("useCidr") var useCidr: Bool = false // save setting
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Network Address: \(checkPrefixEmpty(prefixOne)).\(checkPrefixEmpty(prefixTwo)).\(checkPrefixEmpty(prefixThree)).0/\(cidr.rawValue)")) {
                    TextField("First Prefix", text: $prefixOne)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    TextField("Second Perfix", text: $prefixTwo)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    TextField("Third Prefix", text: $prefixThree)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    Text("Fourth Prefix: 0")
                    if useCidr {
                        Picker("CIDR", selection: $cidr) {
                            ForEach(Cidr.allCases.reversed(), id: \.self) { cidrOption in
                                Text("/\(String(cidrOption.rawValue))")
                            }
                        }
                    } else {
                        Picker("Total IPs", selection: $cidr) {
                            ForEach(Cidr.allCases.reversed(), id: \.self) { cidrOption in
                                Text(networkDesignViewModel.getTotalIps(cidr: cidrOption.rawValue))
                            }
                        }
                    }
                }
                Section {
                    Button("Calculate Pool") {
                        // open NetworkDetailsView in a sheet
                        isShowingNetworkDetailsSheet = true
                        
                        // dismiss keyboard
                        isFocused = false
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(Text("Network Design"))
            .sheet(isPresented: $isShowingNetworkDetailsSheet, content: {
                NavigationStack {
                    NetworkDetailsView(isPresented: isShowingNetworkDetailsSheet, prefixOne: convertPrefixToInt(checkPrefixEmpty(prefixOne)), prefixTwo: convertPrefixToInt(checkPrefixEmpty(prefixTwo)), prefixThree: convertPrefixToInt(checkPrefixEmpty(prefixThree)), cidr: cidr.rawValue)
                }
            })
            .sheet(isPresented: $isShowingNetworkDesignSettingsSheet, content: {
                NavigationStack {
                    NetworkDesignSettingsView(useCidr: $useCidr)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action: {
                                    isShowingNetworkDesignSettingsSheet = false
                                }, label: {
                                    Image(systemName: "xmark")
                                })
                            }
                        }
                }
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingNetworkDesignSettingsSheet = true
                    }, label: {
                        Image(systemName: "gear")
                    })
                }
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
    NetworkDesignView()
}
