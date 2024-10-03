//
//  CustomNavigationController.swift
//  TicTacToeApp
//
//  Created by Максим Горячкин on 30.09.2024.
//

import UIKit

final class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    private func setupAppearance() {
        let font: UIFont = .boldSystemFont(ofSize: 24)
        let titleColor: UIColor = .black
        let standartAppearance = UINavigationBarAppearance()
        standartAppearance.configureWithOpaqueBackground()
        standartAppearance.backgroundColor = .clear
        standartAppearance.titleTextAttributes = [.font: font,
                                                  .foregroundColor: titleColor]
        standartAppearance.shadowColor = .clear
        standartAppearance.setBackIndicatorImage(.backIcon,
                                                 transitionMaskImage: .backIcon)
        standartAppearance.backButtonAppearance  = .init(style: .plain)
        

        let compactAppearance = standartAppearance.copy()
        
        navigationBar.compactAppearance = compactAppearance
        navigationBar.standardAppearance = standartAppearance
        navigationBar.scrollEdgeAppearance = compactAppearance
        navigationBar.compactScrollEdgeAppearance = compactAppearance
        navigationBar.tintColor = .black
    }
    
}
