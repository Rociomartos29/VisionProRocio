//
//  HerosViewModel.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation


final class HerosViewModel: ObservableObject {
    @Published private var heroes: [HerosData] = []
    @Published private var heroes3D: [HerosData] = []
    @Published private var status: Status = .none 
    
    private let useCase: UseCaseHerosProtocol
    
    init(useCase: UseCaseHerosProtocol = UseCaseHeros()) {
        self.useCase = useCase
        fetchHeroes(with: "")
    }
    
    func fetchHeroes(with filter: String) {
        Task {
            do {
                self.status = .loading
                let result = try await useCase.getData(filter: filter)
                DispatchQueue.main.async {
                    self.heroes = result
                    self.heroes3D = result.filter { !$0.id3DModel.isEmpty }
                    self.status = .loaded
                }
            } catch {
                DispatchQueue.main.async {
                    self.status = .error(error: error.localizedDescription)
                }
            }
        }
    }
    
    // Métodos de acceso público para las propiedades privadas
    func getHeroes() -> [HerosData] {
        return heroes
    }
    
    func getHeroes3D() -> [HerosData] {
        return heroes3D
    }
    
    func getStatus() -> Status {
        return status
    }
}
