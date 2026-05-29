//
//  AboutView.swift
//  MyNetworkToolbox
//
//  Created by Miguel Rodriguez on 5/25/26.
//

import SwiftUI

struct AboutView: View {
    private let aboutViewModel = AboutViewModel()
    
    @State private var isShowingCatFactsView: Bool = false
    
    var body: some View {
        let icon = aboutViewModel.icon // get the icon from the ViewModel
        
        NavigationStack {
            VStack {
                Text("About My Network Toolbox")
                    .fontWeight(.bold)
                    .font(.title)
                    .padding(.top, 40)
                    .padding(.bottom, 20)
                    //.frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "person.circle")
                    .font(.system(size: 50))
                    .padding(.bottom, 20)
                    .foregroundColor(.blue)
                Text("This app was developed by Miguel Rodriguez.\n\nThe purpose of this app is to be a collection of small network tools that can help network engineers and technicians in their day to day work.\n\nIf you'd like to contact me please email me at miguelrodriguez2058@gmail.com")
                    .frame(maxWidth: .infinity, alignment: .leading)
                if icon == .leaf {
                    Image(systemName: icon.rawValue)
                        .padding(.top, 40)
                        .font(.system(size: 50))
                        .foregroundColor(.green)
                } else {
                    Image(systemName: icon.rawValue)
                        .padding(.top, 40)
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingCatFactsView = true
                    }, label: {
                        Image(systemName: "cat.fill")
                    })
                }
            }
            .sheet(isPresented: $isShowingCatFactsView) {
                NavigationStack {
                    CatFactsView()
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    isShowingCatFactsView = false
                                }, label: {
                                    Image(systemName: "xmark")
                                })
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    AboutView()
}
