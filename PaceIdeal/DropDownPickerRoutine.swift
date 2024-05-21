//
//  DropDownPickerRoutine.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 20/05/24.
//

import Foundation
import SwiftUI

struct DropDownPickerRoutine: View {
    
    @Binding var selection: String?
    var state: DropDownPickerState = .bottom
    var options: [Routine]
    
    @State var showDropdown = false
    let placeHolder: String
    
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zindex = 1000.0
    
    var body: some View {
        
        GeometryReader {
            let size = $0.size
            
            VStack(alignment: .leading) {
                
                if state == .top && showDropdown {
                    OptionsView()
                }
                
                HStack {
                    Text(selection == nil ? placeHolder : selection!)
                        .foregroundColor(selection != nil ? .textSelect : .textDropDown)
                        .font(.textField)
                    
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: state == .top ? "chevron.up" : "chevron.down")
                        .font(.title3)
                        .foregroundColor(.chevron.opacity(0.4))
                        .rotationEffect(.degrees((showDropdown ? -180 : 0)))
                }
                .padding(.horizontal, 10)
                .frame(width: 292, height: 40) // tamanho do dropdown aparente inicialmente
                .background(.textFieldBackground)
                .contentShape(.rect)
                .onTapGesture {
                    index += 1
                    zindex = index
                    withAnimation(.snappy) {
                        showDropdown.toggle()
                    }
                }
                .zIndex(7)
                
                if state == .bottom && showDropdown {
                    OptionsView()
                }
            }
            .clipped()
            .background(.dropDown)
            .cornerRadius(7)
            .frame(height: size.height, alignment: state == .top ? .bottom : .top)
            
        }
        .frame(width: 292, height: 40) // tamanho do frame dos textos dentro do dropdown
        .zIndex(zindex)
    }
    
    
    func OptionsView() -> some View {
        
        VStack(alignment: .leading, spacing: 0) {
            ForEach(options, id: \.self) { option in
                HStack() {
                    Text(option.rawValue)
                }
                .foregroundStyle(selection == option.rawValue ? .button : .white)
                .animation(.none, value: selection)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .padding(.leading, 6) // ajusta o texto dentro do dropdown
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option.rawValue
                        showDropdown.toggle()
                    }
                }
            }
       }
        .transition(.move(edge: state == .top ? .bottom : .top))
        .zIndex(1)
    }
}
