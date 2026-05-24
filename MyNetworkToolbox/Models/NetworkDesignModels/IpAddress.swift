//
//  IpAddress.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/23/26.
//

import Foundation

// IP Address protocol
protocol IpAddress {
    var prefixOne: Int { get }
    var prefixTwo: Int { get }
    var prefixThree: Int { get }
    var prefixFour: Int { get }
}
