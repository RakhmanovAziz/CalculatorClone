//
//  CircleButton.swift
//  CalculatorClone
//
//  Created by Азиз Рахманов on 11/01/25.
//

import Foundation
import UIKit

final class CircleButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }

    
}
