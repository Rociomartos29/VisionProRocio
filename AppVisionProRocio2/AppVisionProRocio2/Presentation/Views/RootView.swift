//
//  RootView.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import SwiftUI

struct RootView: View {
    
    @EnvironmentObject private var appState: AppStateViewModel
        
    var body: some View {
        ZStack{
            VStack{
                switch(appState.status){
                case .none:
                    LoginView()
                case .error(error: let errorString):
                    Text("Error \(errorString)")
                case .loaded:
                    PrincipalView()
                
                case .loading:
                    HerosView(viewModel: HerosViewModel())
                }
            }
        }
    }
    
}

#Preview {
    RootView()
    .environmentObject(AppStateViewModel())}
