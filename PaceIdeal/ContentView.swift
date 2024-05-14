//
//  ContentView.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 07/05/24.
//

import SwiftUI

struct CustomTextField: View {
    
    @Binding var value: Int?
    let placeholder: String
    let title: String
    
    var body: some View {
        
        ZStack{
            
            VStack (alignment: .leading, spacing: 5){
                
                Text(title)
                    .foregroundStyle(.button)
                TextField(
                    placeholder,
                    value: $value,
                    format: .number
                )
                .padding(.vertical, 6)
                .padding(.leading, 6)
                .background(
                    Color.textFieldBackground
                        .clipShape(
                            .rect(
                                cornerRadius: 7
                            )
                        )
                    )
                }
            }
        }
    }

struct ContentView: View {
    
    @State var age: Int? = nil
    @State var weight: Int? = nil
    @State var height: Int? = nil
    //@State var result: Int?
    @State var selectObjective: Objective = .lazer
    
    var body: some View {
        
        VStack (alignment: .leading)  {
            
            HStack {
                
                Image(.header)
                    .scaledToFit()
                    .padding(.top, 60.0)
                
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("?")
                        .foregroundStyle(.white)
                        .padding(10)
                        .background(Color(.popUp).clipShape(.circle))
                })
                .padding(.trailing, 30)
                
            }
          
            
            VStack (spacing: 20) {
                
                VStack (spacing: 30){
                    
                    VStack () {
                        
                        CustomTextField(value: $age, placeholder: "Idade", title: "Qual é a sua idade?")
                    }
                    
                    VStack () {
                        
                        CustomTextField(value: $weight, placeholder: "Peso", title: "Qual é o seu peso?")
                        
                    }
                    
                    VStack () {
                        
                        CustomTextField(value: $height, placeholder: "Altura", title: "Qual é a sua altura (em cm)?")
                        
                    }
                    
                    VStack () {
                        Text("Qual é o seu objetivo com a corrida?")
                            .foregroundStyle(.button)
                        
                    }
                    
                    VStack () {
                        Text("Sua rotina de exercícios aeróbicos é de:")
                            .foregroundStyle(.button)
                        
                        
                        
                    }
                }
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        Color(.button)
                        Text("Calcule o seu Pace!")
                            .bold()
                            .foregroundStyle(.white)
                    }
                })
                .frame(maxWidth: 293, maxHeight: 64)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 3) // Adiciona uma sombra ao botão
            }
            .padding(.horizontal, 50)
            .containerRelativeFrame(.vertical)
            .keyboardType(.numberPad) // definir o teclado que vai aparecer
        
        }
    }
}

#Preview {
    ContentView()
}
