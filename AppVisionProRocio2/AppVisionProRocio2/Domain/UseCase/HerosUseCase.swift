//
//  HerosUseCase.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation


public protocol UseCaseHerosProtocol {
     func getData(filter: String) async -> [HerosData]
}


public final class UseCaseHeros: UseCaseHerosProtocol{
    let NetWorkHeros = NetworkHeros()
    let NetworkTrans = NetworkTransformationsHero()

    
    public init(){}
    
    public func getData(filter: String = "") async -> [HerosData] {
        var herosFinal = [HerosData]()
        
        //get The Heros
        let heros = await NetWorkHeros.getHeros(filter: filter)
        
        //For Each hero, call to LOcations and transformations
        for hero in heros {
            //Tranformations of Hero
            let trans = await NetworkTrans.getHerosTransformation(idHero: hero.id.uuidString)

            
            
            //Generate final Model and add to Array
            
            let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, transformations: trans)
            herosFinal.append(HeroFin)
            
            
        }
        
        return herosFinal
    }
}



public final class UseCaseHerosFake: UseCaseHerosProtocol{
    let NetWorkHeros = NetworkHerosFake()
    let NetworkTrans = NetworkTransformationsHeroFake()

    
    public init(){}
    
    public func getData(filter: String = "") async -> [HerosData] {
        var herosFinal = [HerosData]()
        
        //get The Heros
        let heros = await NetWorkHeros.getHeros(filter: filter)
        
        //For Each hero, call to LOcations and transformations
        for hero in heros {
            //Tranformations of Hero
            let trans = await NetworkTrans.getHerosTransformation(idHero: hero.id.uuidString)
            

            
            
            //Generate final Model and add to Array
            
            let HeroFin  = HerosData(id: hero.id, favorite: hero.favorite, description: hero.description, photo: hero.photo, name: hero.name, transformations: trans)
            herosFinal.append(HeroFin)
            
            
        }
        
        return herosFinal
    }
}
