//
//  CustomTextField.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 15/05/24.
//

import Foundation
import SwiftUI

struct CustomTextField: View {
    
    @Binding var value: Int?
    let placeHolder: String
    let title: String
    
    var body: some View {
        
        ZStack{
            
            VStack (alignment: .leading, spacing: 5){
                
                Text(title)
                    .foregroundStyle(.button)
                    .font(.text)
                    .bold()
                TextField(
                    placeHolder,
                    value: $value,
                    format: .number,
                    prompt: Text(placeHolder)
                        .foregroundColor(.textDropDown)
                        .font(.textField)
                )
                .foregroundColor(.textSelect)
                .padding(.vertical, 8)
                .padding(.leading, 10)
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
