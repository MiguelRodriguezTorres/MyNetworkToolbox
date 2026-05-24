//
//  NetworkDesignSettingsView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/24/26.
//

import SwiftUI

struct NetworkDesignSettingsView: View {
    @Binding var useCidr: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Use CIDR Notation", isOn: $useCidr)
                }
            }
            .navigationTitle(Text("Settings"))
        }
    }
}

#Preview {
    @Previewable @State var useCidr = true
    
    NetworkDesignSettingsView(useCidr: $useCidr)
}
