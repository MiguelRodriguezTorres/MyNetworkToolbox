//
//  GeneratePasswordView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/30/26.
//

import SwiftUI

struct GeneratePasswordView: View {
    @StateObject private var viewModel = GeneratePasswordViewModel()
    
    @State private var isAlertPresented: Bool = false
    
    @AppStorage("useStrongPassword") private var useStrongPassword: Bool = false // store user option
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("\(useStrongPassword ? "Strong" : "Simple") Password")) {
                    Text(viewModel.password.passwordString.isEmpty ? "Tap the button to generate a password" : viewModel.password.passwordString)
                        .task {
                            do {
                                viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                            } catch {
                                viewModel.password.passwordString = "Error! Try again."
                            }
                        }
                    Toggle("Generate a strong password", isOn: $useStrongPassword)
                        .onChange(of: useStrongPassword) {
                            Task {
                                do {
                                    viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
                                } catch {
                                    viewModel.password.passwordString = "Error! Try again."
                                }
                            }
                        }
                }
                Section {
                    Button(action: {
                        Task {
                            do {
                                viewModel.password.passwordString = try await viewModel.getGeneratedPassword(generateStrongPassword: useStrongPassword)
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
}

#Preview {
    GeneratePasswordView()
}
