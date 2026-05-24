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
}
