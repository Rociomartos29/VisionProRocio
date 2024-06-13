//
//  NetworkLogin.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginApp(user:String, password: String) async -> String
}

final class NetworkLogin: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        var tokenJWT: String = ""
        let urlCad = "\(ConstantsLibrary.CONST_API_URL)\(Endpoints.login.rawValue)"
        let encodeCred = "\(user):\(password)".data(using: .utf8)?.base64EncodedString()
        
        var segCredential: String = ""
        if let credentials = encodeCred {
            segCredential = "Basic \(credentials)"
        }
        
        var request: URLRequest = URLRequest(url: URL(string: urlCad)!)
        request.httpMethod = HTTPMethods.post
        request.addValue(HTTPMethods.content, forHTTPHeaderField: "Content-type")
        request.addValue(segCredential, forHTTPHeaderField: HTTPMethods.content)
        
        // Server Call
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == HTTPResponseCodes.SUCCESS{
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
            
        }catch{
            tokenJWT = ""
        }
        
        return tokenJWT
        
    }
    
    
}

final class NetworkLoginFake: NetworkLoginProtocol {
    func loginApp(user: String, password: String) async -> String {
        UUID().uuidString
    }
    
}
