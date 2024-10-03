//
//  GameVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class GameVC: UIViewController {
    
    // входящие данные
    
    var countPlayers = 2
    
    var timerGame = 60
    //-----------------
    //как передадут стек картинок?
    
    //-----------------
    var playerMove = 1
    let tagButtonLineOne = [1, 2, 3]
    let tagButtonLineTwo = [4, 5, 6]
    let tagButtomLineThree = [7, 8, 9]
    
    
    let labelPlayerOne: UILabel = {
        let label = UILabel()
        label.text = "Player One"
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .boldSystemFont(ofSize: 16)
        label.font = .SFProDisplay.bold.size(of: 16)
        return label
    }()
    
    let labelPlayerTwo: UILabel = {
        let label = UILabel()
        label.text = "Player Two"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .SFProDisplay.bold.size(of: 16)
        return label
    }()
    
    let laybelPlayerMove: UILabel = {
        let label = UILabel()
        label.text = "You turn"
        label.font = .SFProDisplay.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moveImage = UIImageView()
    
    let labelTimerGame: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = .SFProDisplay.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imagePlayerOne: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.image = PlayerMove.Image.X
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imagePlayerTwo: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.image = PlayerMove.Image.O
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let stackView1: UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 30
        stack.backgroundColor = AppColors.basicLightBlue
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true // дает устанавливать отступы
        stack.spacing = 10
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // настройка отступов
        return stack
    }()
    
    let stackView2: UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 30
        stack.backgroundColor = AppColors.basicLightBlue
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true // дает устанавливать отступы
        stack.spacing = 10
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // настройка отступов
        return stack
    }()
    
    let playingFild: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stack.spacing = 20
        stack.axis = .vertical
        stack.layer.cornerRadius = 30
        
        stack.backgroundColor = .white
        
        return stack
    }()
    
    let stackButtonLineOne: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = .white
        return stack
    }()
    
    let stackButtonLineTwo: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = .white
        return stack
    }()
    
    let stackButtonLineThree: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = .white
        return stack
    }()
    
    let stackPlayerMove: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        stack.backgroundColor = AppColors.background
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        
        
        setupPlayingFild()
        configPlayersMove()
        setupConstrein()

        // Do any additional setup after loading the view.
    }
    
    func setupPlayingFild() {
        view.addSubview(stackView1)
        view.addSubview(stackView2)
        view.addSubview(playingFild)
        view.addSubview(labelTimerGame)
        
        createFild(stack: stackButtonLineOne, line: tagButtonLineOne)
        createFild(stack: stackButtonLineTwo, line: tagButtonLineTwo)
        createFild(stack: stackButtonLineThree, line: tagButtomLineThree)
        
        playingFild.addArrangedSubview(stackButtonLineOne)
        playingFild.addArrangedSubview(stackButtonLineTwo)
        playingFild.addArrangedSubview(stackButtonLineThree)
    }
    
    func setupConstrein() {
        
        stackView1.addArrangedSubview(imagePlayerOne)
        stackView1.addArrangedSubview(labelPlayerOne)
        stackView2.addArrangedSubview(imagePlayerTwo)
        stackView2.addArrangedSubview(labelPlayerTwo)
        sizeIconPlayers(stack: stackView1)
        sizeIconPlayers(stack: stackView2)
        
        NSLayoutConstraint.activate( [
            playingFild.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            playingFild.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView1.bottomAnchor.constraint(equalTo: stackPlayerMove.topAnchor, constant: -30),
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            stackPlayerMove.bottomAnchor.constraint(equalTo: playingFild.topAnchor, constant: -30),
            stackPlayerMove.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView2.bottomAnchor.constraint(equalTo: stackPlayerMove.topAnchor, constant: -30),
            labelTimerGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelTimerGame.bottomAnchor.constraint(equalTo: stackPlayerMove.topAnchor, constant: -70)
            
        
        ])
    }
    
    
    func createFild(stack: UIStackView, line: Array<Int>) {
        for item in line.enumerated() {
            let button = createButton(tag: item.element)
            stack.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 74).isActive = true
            button.heightAnchor.constraint(equalToConstant: 74).isActive = true
        }
    }
    
    func createButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.layer.cornerRadius = 20
        button.backgroundColor = AppColors.basicLightBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }
    
    func sizeIconPlayers(stack: UIStackView) {
        stack.widthAnchor.constraint(equalToConstant: 103).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 103).isActive = true
    }
    
    @objc func tapButton(sender: UIButton) {
        print(sender)
        switch playerMove {
        case 1: sender.setImage(PlayerMove.Image.X, for: .normal)
        case 2: sender.setImage(PlayerMove.Image.O, for: .normal)
        default: break
        }
        if playerMove == 1 {
            playerMove = 2
        } else {
            playerMove = 1
        }
        configPlayersMove()
    }
    
    
    func configPlayersMove() {
        
        if countPlayers == 2 {
            switch playerMove {
            case 1: moveImage.image = PlayerMove.Image.X;
                laybelPlayerMove.text = "Player One Turn"
            case 2: moveImage.image = PlayerMove.Image.O;
                laybelPlayerMove.text = "Player Two Turn"
        default: break
        }
            stackPlayerMove.addArrangedSubview(moveImage)
            stackPlayerMove.addArrangedSubview(laybelPlayerMove)
        } else {
            stackPlayerMove.addArrangedSubview(laybelPlayerMove)
        }
        view.addSubview(stackPlayerMove)
    }


}
