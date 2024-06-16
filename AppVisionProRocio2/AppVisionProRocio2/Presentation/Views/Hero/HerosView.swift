//
//  HerosView.swift
//  AppVisionProRocio2
//
//  Created by Rocio Martos on 13/6/24.
//

import SwiftUI

struct HerosView: View {
    @EnvironmentObject private var appState: AppStateViewModel
    @ObservedObject var viewModel: HerosViewModel
       @Environment(\.openWindow) private var openWindow

       @State private var selectedHero: HerosData?
       @State private var searchText = ""

       var body: some View {
           NavigationView {
               VStack {
                   // Search Bar
                   SearchBar(text: $searchText, placeholder: "Buscar héroe por nombre")

                   // List of Heroes
                   List(viewModel.getHeroes()) { hero in
                       NavigationLink(destination: HeroDetailView(hero: hero, viewModel: viewModel, selectedHero: $selectedHero)) {
                           HerosRowView(hero: hero)
                       }
                       .tag(hero)
                   }
                   .navigationTitle("Heroes")
                   .listStyle(PlainListStyle())

                   // Detail or Placeholder
                   if let hero = selectedHero {
                       HeroDetailView(hero: hero, viewModel: viewModel, selectedHero: $selectedHero)
                   } else {
                       Text("Selecciona un héroe")
                           .font(.title)
                           .foregroundColor(.gray)
                           .padding()
                   }
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
           }
       }
   }

   #Preview {
       HerosView(viewModel: HerosViewModel())
   }
