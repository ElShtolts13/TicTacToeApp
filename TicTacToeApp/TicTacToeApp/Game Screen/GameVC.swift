//
//  GameVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class GameVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector (backButtonAction))
        view.backgroundColor = .systemPink
        
    }
    @objc private func backButtonAction() {
        let selectGameVC = SelectGameVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(selectGameVC, animated: true)
    }

}
