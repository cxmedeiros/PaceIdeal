//
//  PopUp.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 16/05/24.
//

import Foundation
import SwiftUI

struct PopUp: View {
    
    var message: AttributedString
    @Binding var isActive: Bool
    
    init(message: String, isActive: Binding<Bool>) {
        self.message = try! AttributedString(
            markdown: message,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        self._isActive = isActive
    }
    
    var body: some View {
        
        ZStack {
            Color(.black)
                .opacity(0.2)
                .onTapGesture {
                    close()
                }
            
            VStack(alignment:.leading, spacing: 50){
                
                Text(message)
                    .font(.popUp)
                    .foregroundStyle(.white)
                
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 100)
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
            .background(.button)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay {
                
                VStack {
                    HStack {
                        Spacer()
                        
                        Button {
                            close()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .padding()
                                .background(Color(.button))
                                .opacity(0.3)
                        }
                        .tint(.white)
                        
                    }
                    Spacer()
                }
                .padding()
            }
            .padding()
            .offset(x: 0, y: isActive ? 0 : 1000)
        }
        .ignoresSafeArea()
        .opacity(isActive ? 1 : 0)
        .animation(.default, value: isActive)
    }
        
        func close() {
            isActive = false
        }
    }


#Preview {
    PopUp(message: """
          **Pace** é o ritmo médio de um corretor em determinado trajeto medido em minutos por quilômetro!
          
          *Exemplo:* Pace de 6’30’', significa que a pessoa gasta em média 6 minutos e 30 segundos para percorrer um quilômetro.
          """, isActive: .constant(true)
    )
}
