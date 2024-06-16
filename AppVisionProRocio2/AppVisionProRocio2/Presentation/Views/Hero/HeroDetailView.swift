//
//  HeroDetailView.swift
//  AppVisionProRocio2
//
//  Created by Rocio Martos on 16/6/24.
//

import SwiftUI

struct HeroDetailView: View {
    var hero: HerosData
       @ObservedObject var viewModel: HerosViewModel
       @Binding var selectedHero: HerosData?

       var body: some View {
           VStack(spacing: 20) {
               AsyncImage(url: URL(string: hero.photo)) { image in
                   image.resizable()
                       .scaledToFit()
                       .cornerRadius(10)
               } placeholder: {
                   ProgressView()
                       .frame(width: 200, height: 200)
                       .padding()
               }

               Text(hero.description)
                   .font(.body)
                   .multilineTextAlignment(.center)
                   .padding()

               Divider()

               // Transformations List
               List(hero.transformations) { transformation in
                   VStack(alignment: .leading, spacing: 10) {
                       AsyncImage(url: URL(string: transformation.photo)) { image in
                           image.resizable()
                               .frame(width: 100, height: 100)
                               .cornerRadius(10)
                       } placeholder: {
                           ProgressView()
                               .frame(width: 100, height: 100)
                       }

                       Text(transformation.name)
                           .font(.headline)

                       Text(transformation.description)
                           .font(.subheadline)
                           .foregroundColor(.gray)
                   }
                   .padding(.vertical, 10)
               }
               .listStyle(PlainListStyle())
           }
           .padding()
           .navigationTitle(hero.name)
           .navigationBarTitleDisplayMode(.inline)
           .toolbar {
               ToolbarItem(placement: .navigationBarTrailing) {
                   Button(action: {
                       selectedHero = nil
                   }) {
                       Image(systemName: "xmark.circle.fill")
                   }
               }
           }
       }
   }

   struct SearchBar: View {
       @Binding var text: String
       var placeholder: String

       var body: some View {
           HStack {
               TextField(placeholder, text: $text)
                   .padding(.horizontal, 20)
                   .padding(.vertical, 10)
                   .background(Color(.systemGray5))
                   .cornerRadius(10)

               if !text.isEmpty {
                   Button(action: {
                       text = ""
                       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                   }) {
                       Image(systemName: "xmark.circle.fill")
                           .foregroundColor(.gray)
                   }
                   .padding(.trailing, 10)
               }
           }
           .padding(.horizontal, 15)
           .padding(.top, 10)
       }
   }

#Preview {
    HeroDetailView(hero: HerosData.getHeroMock(), viewModel: HerosViewModel(), selectedHero: .constant(HerosData.getHeroMock()))
   }
