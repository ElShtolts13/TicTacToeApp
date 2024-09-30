//
//  ResultVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class ResultVC: UIViewController {
    
    // входные  данные результата игры - draw, win, lose
    
    let inputResault = "lose"
    
    //------------------------
    
    //MARK: - Private properties
    
    private let labelResultGame: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageResultGame: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let stackButton = UIStackView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        constreinView()
    }
    
    // MARK: - Private methods
    // создаем экран в зависимости от входящего результата inputResault
    private func createView() {
        view.backgroundColor = .white
        view.addSubview(labelResultGame)
        view.addSubview(imageResultGame)
        view.addSubview(stackButton)
        
        switch inputResault {
        case "win": labelResultGame.text = "Player One win!";
                    imageResultGame.image = ResaultImage.win
        case "lose": labelResultGame.text = "You Lose!";
                    imageResultGame.image = ResaultImage.lose
        case "draw": labelResultGame.text = "Draw!";
                    imageResultGame.image = ResaultImage.draw
        default: break
        }
        createStackButton()
    }
    
    // создаем стэк с кнопками
    private func createStackButton() {
        stackButton.translatesAutoresizingMaskIntoConstraints = false
        stackButton.axis = .vertical
        stackButton.spacing = 12
        stackButton.alignment = .fill
        stackButton.distribution = .fillEqually
        stackButton.addArrangedSubview(createButton(name: "Play again"))
        stackButton.addArrangedSubview(createButton(name: "Back"))
    }
    
    // настраиваем размещение объектов на экране
    private func constreinView() {
        
        NSLayoutConstraint.activate( [
            
            imageResultGame.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            imageResultGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelResultGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelResultGame.bottomAnchor.constraint(equalTo: imageResultGame.topAnchor, constant: -20),
            
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -156 + -20)
            
        
        ])
    }


}

extension ResultVC {
    
    // данный енум стоит перенести в общую модель где будут описаны все имеджи
    enum ResaultImage {
        static let win = UIImage(named: "Win")
        static let draw = UIImage(named: "Draw")
        static let lose = UIImage(named: "Lose")
    }
    
    // метод создания кнопки + привязка действия
    private func createButton(name: String) -> UIButton {
        let collor = UIColor(red: 131/255, green: 128/255, blue: 206/255, alpha: 1)
        let button = UIButton()
        button.setTitle(name, for: .normal)
        button.layer.cornerRadius = 30
        button.layer.borderColor = collor.cgColor
        button.layer.borderWidth = 2
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        if name == "Back" {
            button.backgroundColor = .white
            button.setTitleColor(collor, for: .normal)
        } else {
            button.backgroundColor = collor
            button.setTitleColor(.white, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTaped), for: .touchUpInside)
        return button
    }
    
    // обработка действия кнопки
    @objc private func buttonTaped(_ sender: UIButton) {
        print("User tap \(String(describing: sender.currentTitle))")
        //  переход в зависимости от выбора пользователя
    }

    
}
