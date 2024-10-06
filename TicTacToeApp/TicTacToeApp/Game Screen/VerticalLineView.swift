//
//  VerticalLineView.swift
//  TicTacToeApp
//
//  Created by Максим Горячкин on 05.10.2024.
//

import UIKit

final class VerticalLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.lineWidth = 2
        UIColor.black.setStroke()
        path.stroke()
    }
    
}

final class HorisontalLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.lineWidth = 5
        AppColors.secondaryPurple.setStroke()
        path.stroke()
    }
    
}

final class DiagonaRightlLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: rect.origin)
        path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
        path.lineWidth = 5
        AppColors.secondaryPurple.setStroke()
        path.stroke()
    }
    
}

final class DiagonaLeftlLineView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.minX, y: rect.maxY))
        path.lineWidth = 5
        AppColors.secondaryPurple.setStroke()
        path.stroke()
    }
    
}
