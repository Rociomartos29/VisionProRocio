//
//  AppStateViewModel.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation
import Combine


class AppStateViewModel:ObservableObject {
  
    @Published private(set) var status: Status = .none
    @Published private(set) var isLogged: Bool = false
    @Published private(set) var heroSelected: HerosData?

    private var cancellables = Set<AnyCancellable>()

    init() {
        controlLogin()
    }

    func login(user: String, password: String) {
        Task {
            let loginOK = await UseCaseLogin().loginApp(user: user, password: password)
            DispatchQueue.main.async {
                self.status = loginOK ? .loaded : .error(error: "Usuario/clave no son correctos")
                self.isLogged = loginOK
            }
        }
    }

    func closeSession() {
        UseCaseLogin().closeSession()
        isLogged = false
        status = .none
    }

    private func controlLogin() {
        Task {
            let isLogged = await UseCaseLogin().isLogged()
            DispatchQueue.main.async {
                self.status = isLogged ? .loaded : .none
                self.isLogged = isLogged
            }
        }
    }

    func setHero(hero: HerosData){
        self.heroSelected = hero
    }

}
