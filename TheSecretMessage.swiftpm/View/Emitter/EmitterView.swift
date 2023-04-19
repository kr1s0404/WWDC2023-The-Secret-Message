//
//  SwiftUIView.swift
//  
//
//  Created by Kris on 4/16/23.
//

import SwiftUI

func getRect() -> CGRect {
    return UIScreen.main.bounds
}

enum EmitType {
    case bothWin
    case bothLose
    case playerAWin
    case middleManWin
}

struct EmitterView: UIViewRepresentable {
    
    let result: EmitType
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmiterCells()
        
        emitterLayer.emitterSize = CGSize(width: getRect().width, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: getRect().width / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func createEmiterCells()->[CAEmitterCell] {
        
        var emitterCells: [CAEmitterCell] = []
        
        for index in 1...12 {
            let cell = CAEmitterCell()
            
            switch result {
            case .bothWin:
                cell.contents = UIImage(named: getImage(index: index))?.cgImage
                cell.color = getColor().cgColor
            case .bothLose:
                cell.contents = UIImage(named: "bomb")?.cgImage
            case .playerAWin:
                cell.contents = UIImage(named: getImage(index: index))?.cgImage
                cell.color = getColor().cgColor
            case .middleManWin:
                cell.contents = UIImage(named: "devil")?.cgImage
            }
            
            cell.birthRate = 4.5
            cell.lifetime = 20
            cell.velocity = 120
            cell.scale = 0.2
            cell.scaleRange = 0.3
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            cell.spin = 3.5
            cell.spinRange = 1
            
            cell.yAcceleration = 40
            
            emitterCells.append(cell)
        }
        
        return emitterCells
    }
    
    func getColor() -> UIColor {
        let colors : [UIColor] = [.systemPink,
                                  .systemGreen,
                                  .systemRed,
                                  .systemOrange,
                                  .systemPurple]
        
        return colors.randomElement()!
    }
    
    func getImage(index: Int) -> String {
        if index < 4 {
            return "rectangle"
        } else if index > 5 && index <= 8 {
            return "circle"
        } else {
            return "triangle"
        }
    }
}
