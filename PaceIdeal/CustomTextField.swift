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
                TextField(
                    placeHolder,
                    value: $value,
                    format: .number
                )
                .padding(.vertical, 8)
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
