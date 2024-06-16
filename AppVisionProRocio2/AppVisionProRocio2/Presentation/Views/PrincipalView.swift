//
//  PrincipalView.swift
//  AppVisionProRocio2
//
//  Created by Rocio Martos on 13/6/24.
//

import SwiftUI

import RealityKit
import RealityKitContent


//Aqui solo los TABSView
struct PrincipalView: View {
    @StateObject private var vm = HerosViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                TabView {
                    HerosView(viewModel: vm)
                        .tabItem {
                            Label(
                                title: { Text("Heroes") },
                                icon: { Image(systemName: "house") }
                            )
                        }
                }
            }
        }
        .onAppear {
            Task {
               vm.fetchHeroes(with: "")
            }
        }
    }
}

#Preview {
        PrincipalView()
    }
