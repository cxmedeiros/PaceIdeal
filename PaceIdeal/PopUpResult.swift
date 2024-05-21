//
//  PopUpResult.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 17/05/24.
//

import Foundation
import SwiftUI

struct PopUpResult: View {
    
    var message: AttributedString
    var message1: AttributedString
    var message2: AttributedString
    var image: ImageResource
    @Binding var isActive2: Bool
    
    init(message: String, message1:String, message2: String, isActive2: Binding<Bool>, image: ImageResource) {
        self.message = try! AttributedString(
            markdown: message,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        self.message1 = try! AttributedString(
            markdown: message1,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        self.message2 = try! AttributedString(
            markdown: message2,
            options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
        
        self._isActive2 = isActive2
        
        self.image = image
    }
    
    var body: some View {
        
        ZStack {
            Color(.black)
                .opacity(0.2)
                .onTapGesture {
                    close()
                }
            
            HStack(){
                VStack(alignment:.center, spacing: 10){
                    
                    Text(message)
                        .font(.system(size: 28))
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.bottom, 10)
                    
                    Text(message1)
                        .font(.system(size: 40))
                        .bold()
                        .foregroundStyle(.white)
                    
                    Image(image)
                        .padding(.top, 30)
                        .padding(.bottom, 30)
                    
                    Text(message2)
                        .font(.system(size: 26))
                        .foregroundStyle(.white)
                        .bold()
                    
                }
                .padding(.horizontal, 30)
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 100)
            .padding(.horizontal, 20)
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
            
        }
        .ignoresSafeArea()
        .opacity(isActive2 ? 1 : 0)
        .animation(.easeInOut.speed(2), value: isActive2)
        
    }
    
    func close() {
        isActive2 = false
    }
    
}


#Preview {
    PopUpResult(message: "Seu Pace Ideal é:",
        message1:"6'30''",
        message2:"""
O sedentarismo está
              na porta!
""",
        isActive2: .constant(true),
                image: .fastRunner
    )
}
