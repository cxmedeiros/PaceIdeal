//
//  Objective.swift
//  PaceIdeal
//
//  Created by Camila Xavier de Medeiros on 14/05/24.
//

import Foundation


enum Goal: String, CaseIterable {
    case saude = "Saúde"
    case lazer = "Lazer"
    case maratona = "Maratona"
}

enum Routine: String, CaseIterable {
    case ruim = "2 ou menos dias por semana"
    case medio = "Entre 3 e 5 dias por semana"
    case bom = "Mais de 5 dias por semana"
}

// Estrutura para armazenar os parâmetros do usuário
struct UserParameters {
    var age: Int
    var weight: Int
    var height: Int
    var goal: Goal
    var routine: Routine
    
    // Método para calcular o resultado baseado nos parâmetros
    func calculateResult() -> Float {
        
        let BasicPace = 6.0
        let ageFactor: Float
        let weightFactor: Float
        let heightFactor: Float
        let goalMultiplier: Float
        let routineMultiplier: Float
        
        if age < 30 {
            ageFactor = 0.95
        } else if age >= 30 && age < 50 {
            ageFactor = 1.0
        } else {
            ageFactor = 1.10
        }
        
        if weight < 60 {
            weightFactor = 0.95
        } else if weight >= 60 && weight < 80 {
            weightFactor = 1
        } else {
            weightFactor = 1.05
        }
        
        if height < 160 {
            heightFactor = 1.05
        } else if height >= 160 && height < 180 {
            heightFactor = 1
        } else {
            heightFactor = 0.95
        }
        
        switch goal {
        case .saude:
            goalMultiplier = 1.0
        case .lazer:
            goalMultiplier = 1.10
        case .maratona:
            goalMultiplier = 0.9
        }
        
        switch routine {
        case .ruim:
            routineMultiplier = 1.10
        case .medio:
            routineMultiplier = 1
        case .bom:
            routineMultiplier = 0.90
        }
        
        let result = Float(BasicPace) * ageFactor * weightFactor * heightFactor * goalMultiplier * routineMultiplier
        return result
    }
}
