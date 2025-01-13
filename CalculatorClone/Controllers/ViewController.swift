//
//  ViewController.swift
//  CalculatorClone
//
//  Created by Азиз Рахманов on 05/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var calculator = Calculator()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let inputLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 17
        label.backgroundColor = .clear
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 50, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onSetupView()
        onConfigureView()
        onSetupConstraints()
    }
    
    private func onSetupView() {
        view.addSubview(verticalStack)
        view.addSubview(inputLabel)
        addButtonsToHorizontalStack()
    }
    
    //TODO: разделить на два метода
    //TODO: сделать на кнопку 00 дропдаун с выбором цвета фона калькулятора
    
    private func addButtonsToHorizontalStack() {
        for row in 0..<calculator.buttonTitles.count {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 7
            stack.distribution = .fillEqually
            stack.backgroundColor = .clear
            stack.translatesAutoresizingMaskIntoConstraints = false
            verticalStack.addArrangedSubview(stack)
            
            for index in 0..<calculator.buttonTitles[row].count {
                let button = CircleButton(type: .system)
                button.titleLabel?.font = .systemFont(ofSize: 40, weight: .bold)
                button.translatesAutoresizingMaskIntoConstraints = false
                if row == 0, index < calculator.buttonTitles[row].count - 1 {
                    button.setTitle(calculator.buttonTitles[row][index], for: .normal)
                    button.setTitleColor(.black, for: .normal)
                    button.backgroundColor = .lightGray
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    stack.addArrangedSubview(button)
                } else if index == calculator.buttonTitles[row].count - 1 {
                    button.setTitle(calculator.buttonTitles[row][index], for: .normal)
                    button.setTitleColor(.white, for: .normal)
                    button.backgroundColor = .orange
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    stack.addArrangedSubview(button)
                } else {
                    button.setTitle(calculator.buttonTitles[row][index], for: .normal)
                    button.backgroundColor = .darkGray
                    button.setTitleColor(.white, for: .normal)
                    button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
                    stack.addArrangedSubview(button)
                }
                button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
            }
        }
    }
    
    private func onConfigureView() {
        view.backgroundColor = .red
    }
    
    private func onSetupConstraints() {
        NSLayoutConstraint.activate([
            inputLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            inputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            verticalStack.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            verticalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    //TODO: сделать алерт на ограничения ввода
    //TODO: убрать логику из view, отдавать текст калькулятора
    @objc private func onButtonClick(sender: UIButton) {
        guard let buttonText = sender.titleLabel?.text else {
            return
        }

        let result = calculator.handleButtonPress(buttonText)

        if buttonText == "AC" {
            inputLabel.text = result
            return
        }
        
        if buttonText == "=" {
            inputLabel.text = result
            return
        }
        
        if buttonText == "." {
            inputLabel.text = result
            return
        }
        
        if buttonText == "%" {
            inputLabel.text = result
            return
        }

        if result == "Error" {
            inputLabel.text = result
            return
        }
        
        if inputLabel.text == "0" || inputLabel.text == result {
            inputLabel.text = result
        } else {
            inputLabel.text?.append(buttonText)
        }

        print("Button pressed: \(buttonText)")
        print("Label text: \(inputLabel.text ?? "")")
    }
    
}
