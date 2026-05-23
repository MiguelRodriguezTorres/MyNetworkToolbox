//
//  NetworkDetailsView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/23/26.
//

import SwiftUI

struct NetworkDetailsView: View {
    @Environment(\.dismiss) private var dismiss // ref: https://www.swiftbysundell.com/articles/dismissing-swiftui-modal-and-detail-views/
    
    var prefixOne: Int
    let prefixTwo: Int
    let prefixThree: Int
    let cidr: Int
    let networkDetailsViewModel: NetworkDetailsViewModel
    
    init(isPresented: Bool, prefixOne: Int, prefixTwo: Int, prefixThree: Int, cidr: Int) {
        self.prefixOne = prefixOne
        self.prefixTwo = prefixTwo
        self.prefixThree = prefixThree
        self.cidr = cidr
        
        // initialize networkDetailsViewModel after self initialization
        self.networkDetailsViewModel = NetworkDetailsViewModel(ipPool: IpPool(prefixOne, prefixTwo, prefixThree, slash: cidr))
        //self.$isPresented = isPresented
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Network Address: \(prefixOne).\(prefixTwo).\(prefixThree).0/\(cidr)")
                    Text("Subnet: \(networkDetailsViewModel.subnetMask)")
                    Text("Total IPs: \(networkDetailsViewModel.totalIps)")
                    Text("Gateway Address: \(networkDetailsViewModel.range.gateway)")
                    Text("Broadcast Address: \(networkDetailsViewModel.range.broadcastAddress)")
                }
                Section {
                    Button("Close") {
                        dismiss()
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle(Text("Network Details"))
        }
    }
}

#Preview {
    NetworkDetailsView(isPresented: true, prefixOne: 0, prefixTwo: 0, prefixThree: 0, cidr: Cidr.RawValue.zero)
}
