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
    @State var selection1: Goal? = nil
    @State var selection2: Routine? = nil
    @State var age: Int? = nil
    @State var weight: Int? = nil
    @State var height: Int? = nil
    @State var result: Float?
    @State var failedInput = false
    let titleFillFields = "Preencha todos os campos para calcular seu pace!"
    @State var negativeInput = false
    let titleNegativeFields = "Não pode possuir campos com valores negativos!"
    
    var body: some View {
        
        
        ZStack(alignment: .bottom) {
            Color.white
                        
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
                                .bold()
                            
                            DropDownPicker(
                                selection: $selection1,
                                state: .top,
                                placeHolder: "Objetivo"
                            )
                        }
                        
                        VStack (alignment: .leading, spacing: 5) {
                            Text("Sua rotina de exercicios aeróbicos é:")
                                .foregroundStyle(.button)
                                .font(.text)
                                .bold()
                                .lineLimit(0)
                            
                            DropDownPickerRoutine(
                                selection: $selection2,
                                state: .top,
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
                message2: processSentence(),
                isActive2: $isActive2,
                image: processImage()
            )
            
        }
        .alert(titleFillFields, isPresented: $failedInput){
            Button("OK", role: .cancel, action: {})
        }
        .alert(titleNegativeFields, isPresented: $negativeInput) {
            Button("OK", role: .cancel, action: {})
        }
        .ignoresSafeArea()
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    
    func processPace() {
        
        guard
            let age: Int,
            let weight: Int,
            let height: Int,
            let selection1: Goal,
            let selection2 : Routine
                
        else {
            print("Preencha os campos de entrada")
            failedInput = true
            return
        }
        
        guard age > 0 && weight > 0 && height > 0 else {
            print("Prencha os campos com apenas números positivos!")
            negativeInput = true
            return
        }

        
        let userParams = UserParameters (age: age, weight: weight, height: height, goal: selection1, routine: selection2)
        

        
        self.result = userParams.calculateResult()
        
        isActive2 = true
    }
    
    
    func stringPace() -> String {
        if let pace = result {
            let minutes = Int(pace) // Obtém os minutos (parte inteira do resultado)
            let seconds = Int((pace - Float(minutes)) * 60) // Obtém os segundos (parte decimal do resultado multiplicada por 60)
            return "\(minutes)'\(String(format: "%02d", seconds))''"
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
    
    func processSentence() -> String {
        if let pace = result {
            if pace < 6.0 {
                return """
                UHUU, quase o Relâmpago Mcqueen!
         """
            } else if pace >= 6.0 && pace < 8.0 {
                return """
Bom... Mas da para melhorar!
"""            } else {
                return """
O sedentarismo está
              na porta!
"""
            }
        } else {
            return " "
        }
    }
}


#Preview {
    ContentView()
}
