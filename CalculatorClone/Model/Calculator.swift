//
//  Calculator.swift
//  CalculatorClone
//
//  Created by Азиз Рахманов on 11/01/25.
//

import Foundation

enum CalculatorOperation {
    case add
    case subtract
    case multiply
    case divide
    case none
}

struct Calculator {
    
   let buttonTitles = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["6", "5", "4", "-"],
        ["3", "2", "1", "+"],
        ["00","0", ".", "="]
    ]
    
    private var currentValue: Double = 0.0
    private var previousValue: Double = 0.0
    private var operation: CalculatorOperation = .none
    
    mutating func handleButtonPress(_ buttonText: String) -> String {
        switch buttonText {
        case "AC":
            return clear()
        case "±":
            return toggleSign()
        case "%":
            return calculatePercentage()
        case "÷":
            return setOperation(.divide)
        case "×":
            return setOperation(.multiply)
        case "-":
            return setOperation(.subtract)
        case "+":
            return setOperation(.add)
        case "=":
            return calculateResult()
        default:
            return appendDigit(buttonText)
        }
    }
    
    private mutating func clear() -> String {
        currentValue = 0.0
        previousValue = 0.0
        operation = .none
        return "0"
    }
    
    private mutating func toggleSign() -> String {
        currentValue = -currentValue
        return formatNumber(currentValue)
    }
    
    private mutating func calculatePercentage() -> String {
        currentValue = previousValue * (currentValue / 100)
        return formatNumber(currentValue)
    }
    
    private mutating func setOperation(_ operation: CalculatorOperation) -> String {
        self.operation = operation
        previousValue = currentValue
        currentValue = 0.0
        return formatNumber(currentValue)
    }
    //TODO: Bug 2+2*2 = 4 - исправить
    
    private mutating func calculateResult() -> String {
        switch operation {
        case .add:
            currentValue = previousValue + currentValue
        case .subtract:
            currentValue = previousValue - currentValue
        case .multiply:
            currentValue = previousValue * currentValue
        case .divide:
            if currentValue != 0 {
                currentValue = previousValue / currentValue
            } else {
                return "Error"
            }
        case .none:
            return formatNumber(currentValue)
        }
        
        operation = .none
        previousValue = 0.0
        return formatNumber(currentValue)
    }
    
    private mutating func appendDigit(_ digit: String) -> String {
        if let number = Double(digit) {
            currentValue = currentValue * 10 + number
            return formatNumber(currentValue)
        }
        return formatNumber(currentValue)
    }
    
    private func formatNumber(_ number: Double) -> String {
        let formattedNumber = String(format: "%g", number)
        return formattedNumber
    }
}
