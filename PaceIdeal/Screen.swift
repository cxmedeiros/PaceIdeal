//
//  Screen.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 21/05/24.
//

import Foundation
import SwiftUI

struct Screen: View {
    @State private var isActive = false
    
    var body: some View {
        
        ZStack {
            if isActive {
                ContentView()
            } else {
                ZStack {
                    Image(.homeCover)
                }
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    // Define um atraso de 3 segundos antes de ocultar a tela inicial
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                            self.isActive = true
                        }
                    }
                }
            }
        }
    }
}
