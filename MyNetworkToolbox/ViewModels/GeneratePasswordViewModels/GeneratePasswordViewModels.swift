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
    
    // function to fetch password from https//www.dinopass.com API
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
    
    // function to copy a string to the clipboard
    func copyToClipboard(string: String) {
        UIPasteboard.general.string = string
    }
}
