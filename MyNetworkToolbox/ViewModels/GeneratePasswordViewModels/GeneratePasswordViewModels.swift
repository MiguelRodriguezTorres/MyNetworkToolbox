//
//  GeneratePasswordViewModels.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/30/26.
//

import Foundation
import UIKit.UIPasteboard // for copying to clipboard
internal import Combine

class GeneratePasswordViewModel: ObservableObject {
    @Published var password: Password = Password(passwordString: "")
    @Published var passwordLength: PasswordLength = .twelve // 12 is default
    
    // function to fetch password from https://www.dinopass.com API
    func getGeneratedPassword(generateStrongPassword: Bool) async throws -> String {
        // fetch the request
        guard let url = URL(string: "https://www.dinopass.com/password/\(generateStrongPassword ? "strong" : "simple")") else {
            throw URLError(.badURL)
        }
        
        // API URL return string so no need for JSON decoding
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let password = String(data: data, encoding: .utf8) else {
            return "Error! Try again."
        }
        
        return password
    }
    
    // funciton to fetch a customized password from https://www.dinopass.com API
    func getCustomizedPassword(length: Int, useNumbers: Bool, useSymbols: Bool, useCapitals: Bool) async throws -> String {
        // build the API URL string
        var urlString = "https://www.dinopass.com/password/custom?length=\(length)"
        
        urlString += useNumbers ? "&useNumbers=true" : "&useNumbers=false"
        urlString += useSymbols ? "&useSymbols=true" : "&useSymbols=false"
        urlString += useCapitals ? "&useCapitals=true" : "&useCapitals=false"
        
        // fetch the request
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // API URL returns a string so no need for JSON decoding
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let password = String(data: data, encoding: .utf8) else {
            return "Error! Try again."
        }
        
        return password
    }
    
    // function to copy a string to the clipboard
    func copyToClipboard(string: String) {
        UIPasteboard.general.string = string
    }
}
