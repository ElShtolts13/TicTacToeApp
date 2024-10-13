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
    var model: GameModel
    var gameTime: Double
    let isGameWithAI: Bool
    let difficulty: Difficulty
    var timerOnOff = UserDefaults.standard.bool(forKey: "timerOnOff")
    //-----------------
    //как передадут стек картинок?
    
    //-----------------
    
    var tempTimerGame = Int(UserDefaults.standard.integer(forKey: "selectedTime")) * 60
    var gameLine: UIView?
    
    var timer: Timer?
    var playerMove = 1
    let tagButtonLineOne = [1, 2, 3]
    let tagButtonLineTwo = [4, 5, 6]
    let tagButtomLineThree = [7, 8, 9]
    
    
    let labelPlayerOne: UILabel = {
        let label = UILabel()
        label.text = "Player One"
        label.translatesAutoresizingMaskIntoConstraints = false
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
//        label.text = "00:00"
        label.font = .SFProDisplay.bold.size(of: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imagePlayerOne: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.image = PlayerMove.X
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let imagePlayerTwo: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 30
        image.image = PlayerMove.O
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
    
    private var buttons: [UIButton] = []

    init(gameSettings: SelectGameSettings) {
        self.isGameWithAI = gameSettings.isSinglePlayer
        self.gameTime = gameSettings.gameTime
        self.difficulty = gameSettings.difficulty
        self.model = GameModel(isGameWithAI: gameSettings.isSinglePlayer, playerIsFirst: true, difficult: gameSettings.difficulty)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = AppColors.background
        
        print("\(gameTime)")
        
        
        setupPlayingFild()
        configPlayersMove()
        setupConstrein()
        timerGame()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let customNavigationController = navigationController as? CustomNavigationController {
            customNavigationController.popHandler = { [weak self] in
                self?.exitAlert()
            }
        }
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = ""
        timerUdate()
    }
                        
    func setupPlayingFild() {
        view.addSubview(stackView1)
        view.addSubview(stackView2)
        view.addSubview(playingFild)
        
        
                                                           
        createFild(stack: stackButtonLineOne, line: tagButtonLineOne)
        createFild(stack: stackButtonLineTwo, line: tagButtonLineTwo)
        createFild(stack: stackButtonLineThree, line: tagButtomLineThree)
        
        stackButtonLineOne.subviews.forEach {
            if let button = $0 as? UIButton {
                buttons.append(button)
            }
        }
        
        stackButtonLineTwo.subviews.forEach {
            if let button = $0 as? UIButton {
                buttons.append(button)
            }
        }
        
        stackButtonLineThree.subviews.forEach {
            if let button = $0 as? UIButton {
                buttons.append(button)
            }
        }
        
        playingFild.addArrangedSubview(stackButtonLineOne)
        playingFild.addArrangedSubview(stackButtonLineTwo)
        playingFild.addArrangedSubview(stackButtonLineThree)
    }
    
    private func setupConstrein() {
        
        stackView1.addArrangedSubview(imagePlayerOne)
        stackView1.addArrangedSubview(labelPlayerOne)
        stackView2.addArrangedSubview(imagePlayerTwo)
        stackView2.addArrangedSubview(labelPlayerTwo)
//        sizeIconPlayers(stack: stackView1)
//        sizeIconPlayers(stack: stackView2)
        
        NSLayoutConstraint.activate([
                    stackView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
                    stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                    stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                    stackView2.topAnchor.constraint(equalTo: view.topAnchor, constant: 112),
//                    labelTimerGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    labelTimerGame.topAnchor.constraint(equalTo: view.topAnchor, constant: 152),
                    stackPlayerMove.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    stackPlayerMove.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 30),
                    playingFild.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    playingFild.topAnchor.constraint(equalTo: stackPlayerMove.bottomAnchor, constant: 30),
                    moveImage.heightAnchor.constraint(equalToConstant: 54),
                    moveImage.widthAnchor.constraint(equalToConstant: 54)
                ])
        if timerOnOff {
            view.addSubview(labelTimerGame)
            labelTimerGame.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            labelTimerGame.topAnchor.constraint(equalTo: view.topAnchor, constant: 152).isActive = true
        }
    }
    
    
    private func createFild(stack: UIStackView, line: Array<Int>) {
        for item in line.enumerated() {
            let button = createButton(tag: item.element)
            stack.addArrangedSubview(button)
            button.widthAnchor.constraint(equalToConstant: 74).isActive = true
            button.heightAnchor.constraint(equalToConstant: 74).isActive = true
        }
    }
    
    private func createButton(tag: Int) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.layer.cornerRadius = 20
        button.backgroundColor = AppColors.basicLightBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }
    
//    func sizeIconPlayers(stack: UIStackView) {
////        stack.widthAnchor.constraint(equalToConstant: 103).isActive = true
////        stack.heightAnchor.constraint(equalToConstant: 103).isActive = true
//    }
    
    @objc func tapButton(sender: UIButton) {
        if !isGameWithAI {
            guard model.canMove(at: sender.tag - 1) else { return }
        }
        switch playerMove {
        case 1:
            sender.setImage(PlayerMove.X, for: .normal)
        case 2:
            sender.setImage(PlayerMove.O, for: .normal)
        default: break
        }
        model.move(at: sender.tag - 1)
        if playerMove == 1 {
            playerMove = 2
        } else {
            playerMove = 1
        }
        configPlayersMove()
        
        if let result = model.checkWinner() {
            let resultVC = ResultVC(inputResult: result)
            resultVC.backWasTap = { [weak self] in
                guard let self else { return }
                if !isGameWithAI {
                    model.resetGame(with: playerMove.isMultiple(of: 2))
                } else {
                    model.resetGame(with: false)
                    playerMove = 1
                    configPlayersMove()
                }
                buttons.forEach {
                    $0.setImage(nil, for: .normal)
                }
                gameLine?.removeFromSuperview()
                gameLine = nil
                timerGame()
                tempTimerGame = Int(UserDefaults.standard.integer(forKey: "selectedTime")) * 60
            }
            drawLine(for: model.winCombination)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
                self?.navigationController?.pushViewController(resultVC, animated: true)
                if let customNavigationController = self?.navigationController as? CustomNavigationController {
                    customNavigationController.popHandler = nil
                }
            }
        } else {
            if isGameWithAI, playerMove == 2 {
                let index = model.currentIndex
                let button = buttons[index]
                tapButton(sender: button)
            }
        }
    }
    
    
    func configPlayersMove() {
        
        if countPlayers == 2 {
            switch playerMove {
            case 1: moveImage.image = PlayerMove.X;
                laybelPlayerMove.text = "Player One Turn"
            case 2: moveImage.image = PlayerMove.O;
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
        
    private func timerGame() {
        if timerOnOff {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerUdate), userInfo: nil, repeats: true)
        }
    }
    
    @objc func timerUdate() {
        guard timerOnOff else { return }
        if tempTimerGame != 0 {
            tempTimerGame -= 1
            let minutes = Int(tempTimerGame / 60)
            let seconds = Int(tempTimerGame % 60)
            labelTimerGame.text = String( format: "%02d:%02d", minutes, seconds )
        } else {
            self.timer?.invalidate()
            let resultVC = ResultVC(inputResult: GameResult.draw)
            navigationController?.pushViewController(resultVC, animated: true)
        }

    }
    
    private func drawLine(for combination: [Int]) {
        let xPoint: CGFloat
        let yPoint: CGFloat
        let origin: CGPoint
        let size: CGSize
        var view: UIView?
        var superView: UIView?
        switch combination {
        case [1,2,3]:
            xPoint = 0.0
            yPoint = stackButtonLineOne.bounds.height / 2
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: stackButtonLineOne.bounds.width, height: 2)
            superView = stackButtonLineOne
            view = VerticalLineView(frame: .init(origin: origin, size: size))
        case [4,5,6]:
            xPoint = 0.0
            yPoint = stackButtonLineTwo.bounds.height / 2
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: stackButtonLineTwo.bounds.width, height: 2)
            superView = stackButtonLineTwo
            view = VerticalLineView(frame: .init(origin: origin, size: size))
        case [7,8,9]:
            xPoint = 0.0
            yPoint = stackButtonLineThree.bounds.height / 2
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: stackButtonLineThree.bounds.width, height: 2)
            superView = stackButtonLineThree
            view = VerticalLineView(frame: .init(origin: origin, size: size))
        case [1,4,7]:
            xPoint = playingFild.bounds.width / 5
            yPoint = 0.0
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: 2, height: playingFild.bounds.width)
            superView = playingFild
            view = HorisontalLineView(frame: .init(origin: origin, size: size))
        case [2,5,8]:
            xPoint = playingFild.bounds.width / 2
            yPoint = 0.0
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: 2, height: playingFild.bounds.width)
            superView = playingFild
            view = HorisontalLineView(frame: .init(origin: origin, size: size))
        case [3,6,9]:
            xPoint = 9 * playingFild.bounds.width / 11
            yPoint = 0.0
            origin = .init(x: xPoint, y: yPoint)
            size = .init(width: 2, height: playingFild.bounds.width)
            superView = playingFild
            view = HorisontalLineView(frame: .init(origin: origin, size: size))
        case [1,5,9]:
            xPoint = 0.0
            yPoint = 0.0
            origin = .init(x: xPoint, y: yPoint)
            size = playingFild.bounds.size
            superView = playingFild
            view = DiagonaRightlLineView(frame: .init(origin: origin, size: size))
            view?.backgroundColor = .clear
        case [3,5,7]:
            xPoint = 0.0
            yPoint = 0.0
            origin = .init(x: xPoint, y: yPoint)
            size = playingFild.bounds.size
            superView = playingFild
            view = DiagonaLeftlLineView(frame: .init(origin: origin, size: size))
            view?.backgroundColor = .clear
        default:
            break
        }
        guard let superView, let view else { return }
        superView.addSubview(view)
        gameLine = view
    }
    func exitAlert() {
        let alert = UIAlertController(title: "Точно выйти?", message: "Вы пытаетесь выйти из игры, в меню выбора режима игры.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Подтвердить выход", style: .default) {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default) {[weak self] _ in
            if let customNavigationController = self?.navigationController as? CustomNavigationController {
                customNavigationController.popHandler = { [weak self] in
                    self?.exitAlert()
                }
            }
        })
        present(alert, animated: true)
    }
    
}

//#Preview {
//    GameVC(gameSettings: .init(isSinglePlayer: true, gameTime: 60))
//}
