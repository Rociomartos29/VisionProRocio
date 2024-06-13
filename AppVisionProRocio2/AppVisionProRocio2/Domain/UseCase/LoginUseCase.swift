//
//  LoginUseCase.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation
import KcLibraryswift
public final class UseCaseLogin{
    let netLogin = NetworkLogin()
    
    public init(){}
    /// functionof login in server
    public func loginApp(user: String, password: String) async -> Bool {
            // Assuming netLogin.loginApp(user:password:) returns a String
            let loginResult = await netLogin.loginApp(user: user, password: password)
            
            // Logic to convert the String result to Bool
            return loginResult == "success"
        }
    
    /// function isLogged indicate if the token JWt is valid
    public func isLogged() async -> Bool {
        let value = KeyChainKC().loadKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN)
        if let valor = value {
            if valor != "" {
                return true
            } else{
                return false
            }
        } else {
            return false
        }
    }
    
    /// function close session
    public func closeSession() -> Bool {
        return  KeyChainKC().deleteKC(key: ConstantsLibrary.CONST_TOKEN_ID_KEYCHAIN)
        
    }
    
    
    
}
