//
//  AppVisionProRocio2App.swift
//  AppVisionProRocio2
//
//  Created by Rocio Martos on 13/6/24.
//

import SwiftUI

@main
struct AppVisionProRocio2App: App {
    @State private var appState = AppStateViewModel()
    
    
    var body: some Scene {
        
        //ventana Main
        
        WindowGroup {
            RootView()
                .environmentObject(appState)
            //Tamaño minimo y maximo
                .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
        }
        .windowStyle(.plain) //es una ventana plana normal
        .windowResizability(.contentMinSize)//Aplica al redimensionar los tamaños minimo
    }
}
