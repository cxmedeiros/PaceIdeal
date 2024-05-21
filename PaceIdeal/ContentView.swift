//
//  ContentView.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 07/05/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool = false
    @State var isActive2: Bool = false
    @State var selection1: String? = nil
    @State var selection2: String? = nil
    @State var age: Int? = nil
    @State var weight: Int? = nil
    @State var height: Int? = nil
    @State var result: Float?
    
    
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            ZStack(alignment: .top) {
                Color.clear
                
                HStack {
                    
                    Image(.header)
                        .scaledToFit()
                    Spacer()
                    Button{isActive = true} label: {
                        
                        Text("?")
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color(.popUp).clipShape(.circle))
                    }
                    
                    .padding(.trailing, 30)
                    .padding(.bottom, 40)
                    
                }
                Text("Pace")
                    .padding(.top, 115)
                    .padding(.leading, 130)
                    .foregroundColor(.button)
                    .font(.display)
                Text("Ideal")
                    .padding(.top, 150)
                    .padding(.leading, 190)
                    .foregroundColor(.button)
                    .font(.display)
                
                
            }
            VStack (spacing: 45) {
                
                VStack (alignment:. leading, spacing: 30){
                    
                    VStack () {
                        
                        CustomTextField(value: $age, placeHolder: "Idade", title: "Qual é a sua idade?")
                    }
                    
                    VStack () {
                        
                        CustomTextField(value: $weight, placeHolder: "Peso", title: "Qual é o seu peso?")
                        
                    }
                    
                    VStack () {
                        
                        CustomTextField(value: $height, placeHolder: "Altura", title: "Qual é a sua altura (em cm)?")
                        
                    }
                    
                    VStack (alignment: .leading, spacing: 30){
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Qual é o seu objetivo com a corrida?")
                                .foregroundStyle(.button)
                                .font(.text)
                            
                            DropDownPicker(
                                selection: $selection1,
                                state: .top,
                                options: Goal.allCases, placeHolder: "Objetivo"
                            )
                        }
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Sua rotina de Exercicios aeróbicos é de:")
                                .foregroundStyle(.button)
                                .font(.text)
                            
                            DropDownPickerRoutine(
                                selection: $selection2,
                                state: .top,
                                options: Routine.allCases,
                                placeHolder: "Rotina"
                            )
                        }
                    }
                }
                
                Button{
                     processPace()
                } label: {
                    ZStack {
                        Color(.button)
                        Text("Calcule o seu Pace!")
                            .font(.button)
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: 293, maxHeight: 64)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.3), radius: 12, x: 0, y: 3)
                .padding(.bottom, 50)
                
            }
            .padding(.horizontal, 50)
            .keyboardType(.numberPad) // definir o teclado que vai aparecer
            
            PopUp(message: """
  **Pace** é o ritmo médio de um corretor em determinado trajeto medido em minutos por quilômetro!
  
  *Exemplo:* Pace de 6’30’', significa que a pessoa gasta em média 6 minutos e 30 segundos para percorrer um quilômetro.
  """, isActive: $isActive)
            
//            
            PopUpResult(
                message: "Seu Pace Ideal é:",
                message1: stringPace(),
                message2:"Vamos melhorar?", 
                isActive2: $isActive2,
                image: processImage()
            )
            
        }
        .ignoresSafeArea()
    }
    
    func processPace() {
        
        let userParams = UserParameters (age: age ?? 0, weight: weight ?? 0, height: height ?? 0, goal: Goal(rawValue: selection1 ?? " ") ?? .saude, routine: Routine(rawValue: selection2 ?? " ") ?? .ruim)
        
        self.result = userParams.calculateResult()
        
        isActive2 = true
    }
    
    func stringPace() -> String {
        if let pace = result {
            let minutes = Int(pace) // Obtém os minutos (parte inteira do resultado)
            let seconds = Int((pace - Float(minutes)) * 60) // Obtém os segundos (parte decimal do resultado multiplicada por 60)
            return  "\(minutes)'\(seconds)''"
        } else {
           return "0'00''"
        }
    }
    
    func processImage() -> ImageResource {
        
        if let pace = result {
            if pace < 6.0 {
                return .fastRunner
            } else if pace >= 6.0 && pace < 8.0 {
                return .tiredRunner
            } else {
                return .veryTiredRunner
            }
        } else {
            return .veryTiredRunner
        }
    }
}


#Preview {
    ContentView()
}
