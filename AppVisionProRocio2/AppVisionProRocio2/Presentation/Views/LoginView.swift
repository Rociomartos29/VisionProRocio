//
//  LoginVIew.swift
//  AppVisionProRocio
//
//  Created by Rocio Martos on 13/6/24.
//

import SwiftUI

import RealityKit
import RealityKitContent

struct LoginView: View {
    @EnvironmentObject private var appStateVM: AppStateViewModel
    
    @State private var user: String = ""
    @State private var pass: String = ""
    
    var body: some View {
        VStack {
            // Imagen de fondo
            Image(.cielo)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(Color.black.opacity(0.4))
                .overlay(
                    VStack(spacing: 20) {
                        // Título de bienvenida
                        Text("Welcome to Dragon Ball")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top, 60)
                        
                        // Formulario de login
                        VStack(spacing: 20) {
                            // Campo de texto para el usuario
                            TextField("Usuario", text: $user)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .font(.title2)
                            
                            // Campo de texto para la contraseña
                            SecureField("Clave", text: $pass)
                                .padding()
                                .background(Color.blue.opacity(0.8))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .font(.title2)
                        }
                        .padding(.horizontal, 40)
                        
                        // Botón de login
                        Button(action: {
                            Task {
                                 appStateVM.login(user: self.user, password: self.pass)
                            }
                        }) {
                            Text("Login")
                                .font(.title2)
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    }
                )
        }
    }
}
#Preview {
    LoginView()
}
