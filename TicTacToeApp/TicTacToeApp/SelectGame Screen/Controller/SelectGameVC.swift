//
//  SelectGameVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class SelectGameVC: UIViewController {
    private var gameSettings: SelectGameSettings?
    
    // MARK: - Private properties
    
    private let selectGameView = SelectGameView()  // Вью для выбора игры
    private let selectLevelView = SelectDifficultyView()      // Вью для выбора уровня
    
    private var gameTime = 0.0
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupGameSelectionView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.background
        // Настраиваем представление для выбора игры при загрузке экрана
        setupNavigationBar()
        
    }
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .backIcon, style: .plain, target: self, action: #selector (backButtonAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Setting"), style: .plain, target: self, action: #selector (settingAction))
    }
    // MARK: - Private methods
    
    // Настройка представления для выбора игры
    private func setupGameSelectionView() {
        gameTime = UserDefaults.standard.double(forKey: "selectedTime")
        selectGameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectGameView)
        
        NSLayoutConstraint.activate([
            selectGameView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectGameView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectGameView.widthAnchor.constraint(equalToConstant: 300),
            selectGameView.heightAnchor.constraint(equalToConstant: 336)
        ])
        
        // Привязываем действия к кнопкам
        selectGameView.singlePlayerButton.addTarget(self, action: #selector(handleSinglePlayerSelection), for: .touchUpInside)
        selectGameView.twoPlayersButton.addTarget(self, action: #selector(handleTwoPlayersSelection), for: .touchUpInside)
        selectGameView.leaderboardButton.addTarget(self, action: #selector(handleLeaderboardSelection), for: .touchUpInside)
    }
    
    // Настройка представления для выбора уровня сложности
    private func setupSelectLevelView() {
        selectLevelView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectLevelView)
        
        NSLayoutConstraint.activate([
            selectLevelView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectLevelView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            selectLevelView.widthAnchor.constraint(equalToConstant: 300),
            selectLevelView.heightAnchor.constraint(equalToConstant: 336)
        ])
        
        selectGameView.removeFromSuperview()
        
        // Привязываем действия к кнопкам
        selectLevelView.hardDiffucultyButton.addTarget(self, action: #selector(handleDifficultySelection(_:)), for: .touchUpInside)
        selectLevelView.standartDiffucultyButton.addTarget(self, action: #selector(handleDifficultySelection(_:)), for: .touchUpInside)
        selectLevelView.easyDiffucultyButton.addTarget(self, action: #selector(handleDifficultySelection(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func settingAction() {
        let settingVC = SettingsVC()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc private func backButtonAction() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.popViewController(animated: true)
    }
    
    // Обработчик выбора режима одного игрока
    @objc private func handleSinglePlayerSelection() {
        print("Single Player Selected")
        gameSettings = SelectGameSettings(isSinglePlayer: true, gameTime: gameTime)
        setupSelectLevelView()  // Переход на выбор уровня сложности
    }
    
    // Обработчик выбора режима двух игроков
    @objc private func handleTwoPlayersSelection() {
        print("Two Players Selected")
        gameSettings = SelectGameSettings(isSinglePlayer: false, gameTime: gameTime)
        startTicTacToeGame()
    }
    
    // Обработчик выбора таблицы лидеров
    @objc private func handleLeaderboardSelection() {
        let leaderBoardVC = LeaderBoardVC()
        navigationController?.pushViewController(leaderBoardVC, animated: true)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        print("Leaderboard Selected")
        // Логика для обработки выбора таблицы лидеров
    }
    
    // Обработчик выбора уровня сложности
    // Обработчик выбора сложности
    @objc private func handleDifficultySelection(_ sender: UIButton) {
        if let difficulty = gameSettings?.difficulty, let isSinglePlayer = gameSettings?.isSinglePlayer {
            print("Выбрана сложность: \(difficulty)\nОдиночная игра? \(isSinglePlayer)")
        } else {
            print("Не удалось получить настройки игры")
        }
        // Определение сложности в зависимости от нажатой кнопки
        switch sender {
        case selectLevelView.easyDiffucultyButton:
            gameSettings?.difficulty = .easy
            print(
                """
    Выбрана сложность:\(String(describing: gameSettings?.difficulty))\n
                    Одиночная игра? \(String(describing: gameSettings?.isSinglePlayer))
    """
            )
            
        case selectLevelView.standartDiffucultyButton:
            gameSettings?.difficulty = .medium
            print("Standard difficulty selected")
        case selectLevelView.hardDiffucultyButton:
            gameSettings?.difficulty = .hard
            print("Hard difficulty selected")
        default:
            break
        }
        
        // Проверяем, какая сложность выбрана
        if let selectedDifficulty = gameSettings?.difficulty {
            switch selectedDifficulty {
            case .easy:
                print("Game will start with Easy difficulty.")
            case .medium:
                print("Game will start with Medium difficulty.")
            case .hard:
                print("Game will start with Hard difficulty.")
            }
        }
        
        // После выбора сложности запускаем игру
        startTicTacToeGame()
    }
    
    // Метод для начала игры
    private func startTicTacToeGame() {
        let gameVC = GameVC(gameSettings: gameSettings!)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(gameVC, animated: true)
    }
}

//#Preview {
//    CustomNavigationController(rootViewController: SelectGameVC())
//}
