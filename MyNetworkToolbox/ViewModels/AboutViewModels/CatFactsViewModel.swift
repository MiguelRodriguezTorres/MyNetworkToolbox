//
//  CatFactsViewModel.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/26/26.
//

import Foundation

class CatFactsViewModel {
    // method to initiate GET request to https://catfact.ninja/fact API
    func getCatFact() async throws -> CatFact {
        // first the fetch request
        guard let url = URL(string: "https://catfact.ninja/fact") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //return data
        
        // next decode
        let decoder = JSONDecoder()
        let result = try decoder.decode(CatFact.self, from: data)
        
        return result
    }
}
