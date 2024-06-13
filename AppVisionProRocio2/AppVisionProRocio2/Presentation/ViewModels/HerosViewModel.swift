//
//  HerosViewModel.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation

@Observable
final class HeroesViewModel {
    private var heroes: [HerosData]? // Lista de héroes
    private var heroes3D: [HerosData]?
    private var status = Status.none
    
    private let useCase: UseCaseHerosProtocol
    
    init(useCase: UseCaseHerosProtocol = UseCaseHeros()) {
        self.useCase = useCase
        Task {
            await fetchHeroes(with: "")
        }
    }
    
    func fetchHeroes(with filter: String) async {
        let result = await useCase.getData(filter: filter)
        DispatchQueue.main.async {
            self.heroes = result
            self.heroes3D = result.filter { !$0.id3DModel.isEmpty }
        }
    }
    
    // Métodos de acceso público para las propiedades privadas
    func getHeroes() -> [HerosData]? {
        return heroes
    }
    
    func getHeroes3D() -> [HerosData]? {
        return heroes3D
    }
    
    func getStatus() -> Status {
        return status
    }
}
