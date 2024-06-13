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
    
    @State private var user: String = "bejl@keepcoding.es"
    @State private var pass: String = "123456"
    
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
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .font(.title2)
                            
                            // Campo de texto para la contraseña
                            SecureField("Clave", text: $pass)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                                .font(.title2)
                        }
                        .padding(.horizontal, 40)
                        
                        // Botón de login
                        Button(action: {
                            Task {
                                await appStateVM.login(user: self.user, password: self.pass)
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
            
            // Vista de RealityKit para cargar sonido
            RealityView { content in
                if let scene = try? await Entity(named: "Login", in: realityKitContentBundle) {
                    guard let soundEmitter = scene.findEntity(named: "SoundEmitter") else {
                        NSLog("Emitter no encontrado en la escena Login")
                        return
                    }
                    
                    guard let resourceSound = try? await AudioFileResource(named: "/Root/dragonballMain_wav", from: "Login.usda", in: realityKitContentBundle) else {
                        NSLog("No encuentra el sonido")
                        return
                    }
                    
                    let audio = soundEmitter.prepareAudio(resourceSound)
                    audio.play()
                    content.add(scene)
                }
            }
            .frame(height: 200)
        }
    }
}
#Preview {
    LoginView()
}
