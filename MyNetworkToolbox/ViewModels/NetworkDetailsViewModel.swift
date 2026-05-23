//
//  NetworkDetailsViewModel.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/23/26.
//

import Foundation

struct NetworkDetailsViewModel {
    // NetworkDetailsViewModel Properties
    let ipPool: IpPool
    
    var subnetMask: String {
        getSubnetMask(cidr: ipPool.cidr)
    }
    
    var totalIps: Int {
        getTotalIps(cidr: ipPool.cidr)
    }
    
    var range: (gateway: String, broadcastAddress: String) {
        let rangeValues = getRange(ipPool.prefixOne, ipPool.prefixTwo, ipPool.prefixThree, cidr: ipPool.cidr, subnetMask: subnetMask, totalIps: totalIps)
        
        return (gateway: rangeValues.gateway, broadcastAddress: rangeValues.broadcastAddress)
    }
    
    // NetworkDetailsViewModel methods
    // The stuff that makes the magic happen!
    
    // convert binary string to Int
    // function from https://swift.oz-apps.com/2015/09/convert-binary-string-to-integer/
    private func binaryToInt(_ binaryString: String) -> Int {
        return Int(strtoul(binaryString, nil, 2))
    }
    
    // convert int to binary string
    private func intToBinaryString(_ number: Int) -> String {
        let binaryString = String(number, radix: 2)
        let paddedBinary = String(repeating: "0", count: 8 - binaryString.count) + binaryString
        
        return paddedBinary
    }
    
    // function to get binary prefixes from network address
    private func getBinaryAddress(_ prefixOne: Int, _ prefixTwo: Int, _ prefixThree: Int, _ prefixFour: Int) -> String {
        let binaryNetworkAddress = "\(intToBinaryString(prefixOne)).\(intToBinaryString(prefixTwo)).\(intToBinaryString(prefixThree)).\(intToBinaryString(prefixFour))"
        
        return binaryNetworkAddress
    }
    
    // function to get total IP addresses in network
    func getTotalIps(cidr: Int) -> Int {
        // get host bits
        let hostBits = 32 - cidr
        
        // calculate 2 to the power of hostBits
        let totalIpAddresses = Int(pow(2.0, Double(hostBits)))
        
        return totalIpAddresses
    }
    
    // function to get subnet mask using cidr
    private func getSubnetMask(cidr: Int) -> String {
        let binaryString = String(repeating: "1", count: cidr) + String(repeating: "0", count: 32 - cidr)
        
        let binaryArray = binaryString.split(separator: "")
        
        let prefixOne = binaryArray[0...7].joined()
        let prefixTwo = binaryArray[8...15].joined()
        let prefixThree = binaryArray[16...23].joined()
        let prefixFour = binaryArray[24...31].joined()
        
        let subnetMask = "\(binaryToInt(prefixOne)).\(binaryToInt(prefixTwo)).\(binaryToInt(prefixThree)).\(binaryToInt(prefixFour))"
        
        return subnetMask
    }
    
    // function to print gateway and broadcast addresses
    func getRange(_ prefixOne: Int, _ prefixTwo: Int, _ prefixThree: Int, cidr: Int, subnetMask: String, totalIps: Int) -> (gateway: String, broadcastAddress: String) {
        // get the gateway address and the subnet mask
        let gateway = ("\(prefixOne).\(prefixTwo).\(prefixThree).1")
        //var broadcast = ""
        
        let binaryNetAddress = getBinaryAddress(prefixOne, prefixTwo, prefixThree, 1)
        
        // remove the . from binaryNetAddress
        let rawBinaryNetAddress = binaryNetAddress.replacingOccurrences(of: ".", with: "")
        
        var bitIndex = 1
        var broadcastRawBinaryAddress = ""
        
        for bit in rawBinaryNetAddress {
            if bitIndex <= cidr {
                broadcastRawBinaryAddress.append(bit)
                bitIndex += 1
            }
        }
        
        while broadcastRawBinaryAddress.count < 32 {
            broadcastRawBinaryAddress.append("1")
        }
        
        var broadcastBinPrefixOne = ""
        var broadcastBinPrefixTwo = ""
        var broadcastBinPrefixThree = ""
        var broadcastBinPrefixFour = ""
        
        // split broadcastRawBinaryAddress
        var broadcastIndex = 1
        
        for bit in broadcastRawBinaryAddress {
            if broadcastIndex <= 8 {
                broadcastBinPrefixOne.append(bit)
                broadcastIndex += 1
            } else if broadcastIndex <= 16 {
                broadcastBinPrefixTwo.append(bit)
                broadcastIndex += 1
            } else if broadcastIndex <= 24 {
                broadcastBinPrefixThree.append(bit)
                broadcastIndex += 1
            } else if broadcastIndex <= 32 {
                broadcastBinPrefixFour.append(bit)
                broadcastIndex += 1
            }
        }
        
        let broadcastAddress = "\(binaryToInt(broadcastBinPrefixOne)).\(binaryToInt(broadcastBinPrefixTwo)).\(binaryToInt(broadcastBinPrefixThree)).\(binaryToInt(broadcastBinPrefixFour))"
        
//        print("Gateway: \(gateway)")
//        print("Broadcast Address: \(broadcastAddress)")
        
        return (gateway: gateway, broadcastAddress: broadcastAddress)
    }
}
