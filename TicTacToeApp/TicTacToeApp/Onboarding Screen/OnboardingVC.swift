//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class OnboardingVC: UIViewController {
    
    // MARK: - Private properties
    
    var settingVC: SettingVC?
    var rulesVC: HowToPlayVC?
    
    private let xoImage = UIImageView(image: UIImage(named: "XO"))
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Setting"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let rulesButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Question"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameGameLabel: UILabel = {
        let label = UILabel()
        label.text = "TIC-TAC-TOE"
        label.textAlignment = .center
        label.font = .SFProDisplay.bold.size(of: 32)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
    private let playButton = UIButton.createButton(title:"Let's play",
                                           foregroundColor: .white,
                                           backgroundColor: AppColors.basicBlue)
   
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupView()
        
        rulesButton.addTarget(self, action: #selector(pressedRulesButton), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(pressedSettingButton), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(pressedPlayButton), for: .touchUpInside)
        

    }
    
    
    
    func setupView() {
        
        view.addSubview(settingButton)
        view.addSubview(rulesButton)
        view.addSubview(xoImage)
        view.addSubview(nameGameLabel)
        view.addSubview(playButton)
        
        playButton.translatesAutoresizingMaskIntoConstraints = false
        xoImage.translatesAutoresizingMaskIntoConstraints = false
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            settingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            rulesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            rulesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            xoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            xoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            
            nameGameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameGameLabel.topAnchor.constraint(equalTo: xoImage.bottomAnchor, constant: 20),
            
            playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -45),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)

        ])
    }
    
    // MARK: - Actions
    
    @objc private func pressedRulesButton() {
        print("RulesButton was pressed")
        
    }
    @objc private func pressedSettingButton() {
        print("SettingButton was pressed")
        
    }
    @objc private func pressedPlayButton() {
        print("PlayButton was pressed")
        
    }
}
