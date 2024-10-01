//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class OnboardingVC: UIViewController {
    
    
    let xoImage = UIImageView(image: UIImage(named: "XO"))
    
    private let nameGame: UILabel = {
        let label = UILabel()
        label.text = "TIC-TAC-TOE"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28.0, weight: .medium)
        label.textColor = UIColor(red: 137/255, green: 68/255, blue: 171/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let playButton = UIButton.createButton(title:"Let's play",
                                           backgroundColor: AppColors.basicBlue)
   
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playButton)
        view.addSubview(xoImage)
        setupView()
    }
    
    
    
    func setupView() {
        xoImage.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            xoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            xoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)


        ])
    }
}
