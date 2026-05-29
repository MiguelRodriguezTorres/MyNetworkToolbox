//
//  CatFact.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/26/26.
//

import Foundation

// cat facts - ref https://catfact.ninja/fact
struct CatFact: Codable {
    let fact: String
    let length: Int
}
