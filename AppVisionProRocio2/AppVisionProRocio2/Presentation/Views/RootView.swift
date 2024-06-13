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
                    LoginVIew()
                case .error(error: let errorString):
                    Text("Error \(errorString)")
                case .loaded:
                    "Loaded"
                }
            }
        }
    }
    
}

#Preview {
    RootView()
    .environmentObject(AppStateViewModel())}
