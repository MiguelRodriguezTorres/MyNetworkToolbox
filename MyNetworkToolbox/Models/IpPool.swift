//
//  IpAddress.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/21/26.
//

import Foundation

// IpPool Struct
struct IpPool: IpAddress {
    let prefixOne: Int
    let prefixTwo: Int
    let prefixThree: Int
    //let cidr: Cidr
    let cidr: Int
    
    let prefixFour = 0 // always zero for network address
    
    init(_ prefixOne: Int, _ prefixTwo: Int, _ prefixThree: Int, slash cidr: Int) {
        self.prefixOne = prefixOne
        self.prefixTwo = prefixTwo
        self.prefixThree = prefixThree
        self.cidr = cidr
    }
}
