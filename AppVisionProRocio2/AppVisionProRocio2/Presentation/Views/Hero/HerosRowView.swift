//
//  HerosRowView.swift
//  AppVisionProRocio2
//
//  Created by Rocio Martos on 16/6/24.
//

import SwiftUI

struct HerosRowView: View {
    var hero: HerosData

        var body: some View {
            HStack(spacing: 15) {
                AsyncImage(url: URL(string: hero.photo)) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }

                VStack(alignment: .leading, spacing: 5) {
                    Text(hero.name)
                        .font(.headline)
                    Text(hero.description)
                        .font(.subheadline)
                        .lineLimit(2)
                }
            }
            .padding(.vertical, 5)
        }
    }




#Preview {
    HerosRowView(hero: HerosData.getHeroMock())

}
