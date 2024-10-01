
//
//  SelectGameView.swift
//  TicTacToeApp
//
//  Created by salfetkafive on 30.09.2024.
//

import UIKit


class SelectGameView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Game"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    

     lazy var singlePlayerButton = UIButton.createButton(icon: "SinglePlayer", title: "Single Player")

     lazy var twoPlayersButton = UIButton.createButton(icon: "TwoPlayers", title: "Two Players")
     lazy var leaderboardButton = UIButton.createButton(icon: "LeaderBoard", title: "Leaderboard")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5
        
        addSubview(titleLabel)
        addSubview(stackView)
        
        stackView.addArrangedSubview(singlePlayerButton)
        stackView.addArrangedSubview(twoPlayersButton)
        stackView.addArrangedSubview(leaderboardButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    

    
   
}
