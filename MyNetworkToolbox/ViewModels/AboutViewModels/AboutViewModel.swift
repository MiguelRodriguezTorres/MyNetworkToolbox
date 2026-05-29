//
//  AboutViewModel.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/26/26.
//

import Foundation

class AboutViewModel {
    var icon: Icons {
        guard let icon = Icons.allCases.randomElement() else {
            return .leaf // default icon
        }
        
        return icon
    }
    
    // retrieve a random icon from the Icons enum
//    func getRandIcon() -> Icons {
//        guard let icon = Icons.allCases.randomElement() else {
//            return .leaf // default icon
//        }
//        
//        return icon
//    }
}
