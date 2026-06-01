//
//  GeneratePasswordView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/30/26.
//

import SwiftUI

struct GeneratePasswordView: View {
    @StateObject private var viewModel = GeneratePasswordViewModel()
    
    @State private var secionHeader: String = "Password"
    
    // clipboard message alert
    @State private var isAlertPresented: Bool = false
    
    // custom password options
    @State private var useNumbers: Bool = false
    @State private var useSymbols: Bool = false
    @State private var useCapitals: Bool = false
    
    // store user options
    @AppStorage("useCustomPassword") private var useCustomPassword: Bool = false
    @AppStorage("useStrongPassword") private var useStrongPassword: Bool = false
    
    var body: some View {
        // closure for section header
        let getSectionHeaderText = { () -> String in
            if useCustomPassword {
                return "Custom Password"
            } else {
                return useStrongPassword ? "Strong Password" : "Simple Password"
            }
        }
        
        NavigationStack {
            Form {
                Section(header: Text(getSectionHeaderText())) {
                    Text(viewModel.password.passwordString.isEmpty ? "Tap the button to generate a password" : viewModel.password.passwordString)
                        .task {
                            do {
                                if useCustomPassword {
                                    viewModel.password.passwordString = try await viewModel.getCustomizedPassword(length: viewModel.passwordLength.rawValue, useNumbers: useNumbers, useSymbols: useSymbols, useCapitals: useCapitals)
                                } else {
                                    viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                                }
                            } catch {
                                viewModel.password.passwordString = "Error! Try again."
                            }
                        }
                    Toggle("Use custom password parameters", isOn: $useCustomPassword)
                        .onChange(of: useCustomPassword) {
                            Task {
                                do {
                                    if useCustomPassword {
                                        viewModel.password.passwordString = try await viewModel.getCustomizedPassword(length: viewModel.passwordLength.rawValue, useNumbers: useNumbers, useSymbols: useSymbols, useCapitals: useCapitals)
                                    } else {
                                        viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                                    }
                                } catch {
                                    viewModel.password.passwordString = "Error! Try again."
                                }
                            }
                        }
                    if useCustomPassword {
                        Picker("Password length", selection: $viewModel.passwordLength) {
                            ForEach(PasswordLength.allCases, id: \.self) { length in
                                Text("\(length.rawValue)")
                            }
                        }
                        Toggle("Use Numbers", isOn: $useNumbers)
                        Toggle("Use Symbols", isOn: $useSymbols)
                        Toggle("Use Capitals", isOn: $useCapitals)
                    } else {
                        Toggle("Generate a strong password", isOn: $useStrongPassword)
                            .onChange(of: useStrongPassword) {
                                Task {
                                    do {
                                        if useCustomPassword {
                                            viewModel.password.passwordString = try await viewModel.getCustomizedPassword(length: viewModel.passwordLength.rawValue, useNumbers: useNumbers, useSymbols: useSymbols, useCapitals: useCapitals)
                                        } else {
                                            viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                                        }
                                    } catch {
                                        viewModel.password.passwordString = "Error! Try again."
                                    }
                                }
                            }
                    }
                }
                Section {
                    Button(action: {
                        Task {
                            do {
                                if useCustomPassword {
                                    viewModel.password.passwordString = try await viewModel.getCustomizedPassword(length: viewModel.passwordLength.rawValue, useNumbers: useNumbers, useSymbols: useSymbols, useCapitals: useCapitals)
                                } else {
                                    viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                                }
                            } catch {
                                viewModel.password.passwordString = "Error! Try again."
                            }
                        }
                    }, label: {
                        Text("Generate Password")
                    })
                    .frame(maxWidth: .infinity)
                }
                Section {
                    Button(action: {
                        viewModel.copyToClipboard(string: viewModel.password.passwordString)
                        
                        // show alert
                        isAlertPresented = true
                    }, label: {
                        Text("Copy to Clipboard")
                    })
                    .frame(maxWidth: .infinity)
                }
                Section {
                    HStack {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.blue)
                        Text("Passwords generated with\nhttps://www.dinopass.com")
                    }
                }
            }
            .navigationTitle("Generate Password")
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text("Password Copied!"), message: Text("Password was copied to the clipboard."), dismissButton: .default(Text("Nice!")))
            }
        }
    }
    
    // change secion header
//    private func getSectionHeaderText() -> String {
//        if useCustomPassword {
//            return "Custom Password"
//        } else {
//            return useStrongPassword ? "Strong Password" : "Simple Password"
//        }
//    }
}

#Preview {
    GeneratePasswordView()
}
