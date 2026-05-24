//
//  NetworkDesignSettingsViewModel.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/24/26.
//

import Foundation
internal import Combine

class NetworkDesignViewModel: ObservableObject {
    @Published var networkDesignSettings = NetworkDesignSettings()
    
    // function to get total IP addresses in network
    func getTotalIps(cidr: Int) -> String {
        // number formatter for formatting return number string
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal // Use .decimal for standard numerical formatting
        formatter.maximumFractionDigits = 0 // Set to 0 if you only want integers (or adjust as needed)
        formatter.usesGroupingSeparator = true // This is what enables the comma separation
        
        // get host bits
        let hostBits = 32 - cidr
        
        // calculate 2 to the power of hostBits
        let totalIpAddresses = Int(pow(2.0, Double(hostBits)))
        
        // unwrap number into string
        guard let formattedIpAddresses = formatter.string(from: NSNumber(value: totalIpAddresses)) else {
            return "0"
        }
        
        return formattedIpAddresses
    }
}
