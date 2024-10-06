//
//  SettingVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    var selectedButtonIndex: Int? = nil
    var selectedDurationButton: UIButton? = nil
    var buttons: [UIButton] = [] //первая кнопка не сбрасывалась
    var durationView: UIView!
    var switchControl: UISwitch!
    var selectedIcons: [String] = []
    var buttonsStack: UIStackView?
//    var timerOnOff: Bool {
//        if UserDefaults.standard.bool(forKey: "timerOnOff") {
//            false
//        } else {
//            UserDefaults.standard.bool(forKey: "timerOnOff")
//        }
//    }
    
    let imageNames = [
        "Cross", "Nought",
        "CrossWithBg", "NoughtWithBg",
        "Pie", "IceCream",
        "CrossYelow", "NoughtGreen",
        "Star", "Heart",
        "Burger", "FrenchFries"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("\(timerOnOff)!!!!!!!!!!!")
        print("\(UserDefaults.standard.bool(forKey: "timerOnOff"))!!!!!!!!!!!!!!!")
        view.backgroundColor = AppColors.background
        title = "Settings Game"
        // MARK: ВЬЮХИ
        let scrollView = UIScrollView()
        
        let upperStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = .white
            stackView.axis = .vertical
            stackView.distribution = .fillProportionally // или все-таки .fillequally
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            stackView.spacing = 20
            stackView.layer.cornerRadius = 30
            return stackView
        }()
        
        let lowerStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = AppColors.background
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 20
            return stackView
        }()
        
        let leftColumnStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = AppColors.background
            stackView.axis = .vertical
            stackView.spacing = 20
            return stackView
        }()
        
        let rightColumnStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.backgroundColor = AppColors.background
            stackView.axis = .vertical
            stackView.spacing = 20
            return stackView
        }()
        
        view.addSubview(scrollView)
        scrollView.addSubview(upperStackView)
        scrollView.addSubview(lowerStackView)
        lowerStackView.addArrangedSubview(leftColumnStackView)
        lowerStackView.addArrangedSubview(rightColumnStackView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        upperStackView.translatesAutoresizingMaskIntoConstraints = false
        lowerStackView.translatesAutoresizingMaskIntoConstraints = false
        leftColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        rightColumnStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: Констрейнты
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                        
            upperStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            upperStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            upperStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            upperStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            
            lowerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lowerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            lowerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            lowerStackView.topAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: 20),
            lowerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
        
        loadSettings()
        
        let gameTimeView = createGameTimeView() // Наполнение upperStackView (базовый вариант)
        durationView = createDurationView()

        upperStackView.addArrangedSubview(gameTimeView)
        upperStackView.addArrangedSubview(durationView)
            
        durationView.isHidden = true
        let switchControl = gameTimeView.subviews.compactMap { $0 as? UISwitch }.first
        switchControl?.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        // MARK: Добавляем блоки вниз
        for index in 0..<6 {
            if index < 3 {
                leftColumnStackView.addArrangedSubview(createBlock(index: index))
            } else {
                rightColumnStackView.addArrangedSubview(createBlock(index: index))
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Settings"
        
        switchValueChanged(switchControl)
        
        let time = UserDefaults.standard.integer(forKey: "selectedTime")
        buttonsStack?.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                if button.tag == time {
                    durationButtonTapped(button)
                }
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if UserDefaults.standard.value(forKey: "selectedTime") == nil {
            UserDefaults.standard.set(false, forKey: "timerOnOff")
        }
    }
    // MARK: Верхние блоки
    func createGameTimeView() -> UIView {
        let view = UIView()
        view.backgroundColor = AppColors.basicLightBlue
        view.layer.cornerRadius = 30
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.text = "Game Time"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switchControl = UISwitch()
        switchControl.isOn = UserDefaults.standard.bool(forKey: "timerOnOff")
        switchControl.onTintColor = AppColors.basicBlue
        switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, switchControl])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

        return view
    }

    func createDurationView() -> UIView {
        let view = UIView()
        view.backgroundColor = AppColors.basicLightBlue
        view.layer.cornerRadius = 30
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        view.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.text = "Duration"
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let lineView = UIView()
        lineView.backgroundColor = .lightGray
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true

        let buttonStackView = UIStackView()
        let durations = [1, 2, 5]
        buttonsStack = buttonStackView

        for duration in durations {
            let button = UIButton(type: .system)
            button.setTitle("\(String(duration)) min", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .regular)
            button.contentHorizontalAlignment = .left
            button.backgroundColor = .clear
            button.tag = duration
            button.addTarget(self, action: #selector(durationButtonTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            buttonStackView.addArrangedSubview(button)
        }
        
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [titleLabel, lineView, buttonStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill

        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])

        return view
    }
    
    // MARK: Функция для блоков внизу
    func createBlock(index: Int) -> UIView {
        let blockView = UIView()
        blockView.backgroundColor = .white
        blockView.layer.cornerRadius = 30
        
        let imagesStackView = UIStackView()
        imagesStackView.axis = .horizontal
        imagesStackView.spacing = 4
        imagesStackView.distribution = .fillEqually
        
        let firstImageName = imageNames[index * 2]
        let secondImageName = imageNames[index * 2 + 1]
        
        let imageView1 = UIImageView(image: UIImage(named: firstImageName))
        imageView1.contentMode = .scaleAspectFit
        imageView1.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        let imageView2 = UIImageView(image: UIImage(named: secondImageName))
        imageView2.contentMode = .scaleAspectFit
        imageView2.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        imagesStackView.addArrangedSubview(imageView1)
        imagesStackView.addArrangedSubview(imageView2)
        
        let button = UIButton(type: .system)
        button.setTitle("Choose", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = AppColors.basicLightBlue
        button.layer.cornerRadius = 20
        button.tag = index // Устанавливаем тег для идентификации кнопки
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 39).isActive = true
        
        buttons.append(button) //первая кнопка не сбрасывалась
        
        button.addTarget(self, action: #selector(handleButtonPress(_:)), for: .touchUpInside)
        
        let blockStackView = UIStackView(arrangedSubviews: [imagesStackView, button])
        blockStackView.axis = .vertical
        blockStackView.spacing = 10
        blockStackView.alignment = .fill
        blockStackView.translatesAutoresizingMaskIntoConstraints = false
        blockView.addSubview(blockStackView)
        
        NSLayoutConstraint.activate([
            blockStackView.leadingAnchor.constraint(equalTo: blockView.leadingAnchor, constant: 20),
            blockStackView.trailingAnchor.constraint(equalTo: blockView.trailingAnchor, constant: -20),
            blockStackView.topAnchor.constraint(equalTo: blockView.topAnchor, constant: 10),
            blockStackView.bottomAnchor.constraint(equalTo: blockView.bottomAnchor, constant: -20)
        ])
        
        print("\(firstImageName) and \(secondImageName)")
        
        return blockView
    }
    
    // MARK: USERDEFAULTS
    func loadSettings() {
        let defaults = UserDefaults.standard
            
        if let savedIcons = defaults.array(forKey: "selectedIcons") as? [String] {
            selectedIcons = savedIcons
        }
        
        if let savedTime = defaults.string(forKey: "selectedTime") {
            for button in buttons {
                if button.currentTitle == savedTime {
                    durationButtonTapped(button)
                    break
                }
            }
        }
    }
        
    func saveSettings() {
        let defaults = UserDefaults.standard
        defaults.set(selectedIcons, forKey: "selectedIcons")
        if let selectedDurationButton = selectedDurationButton {
//            defaults.set(selectedDurationButton.currentTitle, forKey: "selectedTime")
            defaults.set(selectedDurationButton.tag, forKey: "selectedTime")
        }
    }
    
    // MARK: ЛОГИКА
    @objc func handleButtonPress(_ sender: UIButton) {
        // Сбрасываем все кнопки
        for button in buttons {
            button.setTitle("Choose", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = AppColors.basicLightBlue
        }
            
        sender.setTitle("Picked", for: .normal)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        sender.setTitleColor(.white, for: .normal)
        sender.backgroundColor = AppColors.basicBlue
        
        selectedButtonIndex = sender.tag // запоминаем индекс нажатой кнопки
        
        let selectedFirstIcon = imageNames[selectedButtonIndex! * 2]
        let selectedSecondIcon = imageNames[selectedButtonIndex! * 2 + 1]
        
        if selectedIcons.count >= 2 {
            selectedIcons[0] = selectedFirstIcon
            selectedIcons[1] = selectedSecondIcon
        } else {
            selectedIcons.append(selectedFirstIcon)
            selectedIcons.append(selectedSecondIcon)
        }
        
        saveSettings()
        
        print("Selected icons: \(selectedIcons)")
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        durationView.isHidden = !sender.isOn
        UserDefaults.standard.set(sender.isOn, forKey: "timerOnOff")
    }

    @objc func durationButtonTapped(_ sender: UIButton) {
        if let previousSelectedButton = selectedDurationButton {
            previousSelectedButton.backgroundColor = .clear
            previousSelectedButton.setTitleColor(.black, for: .normal)
        }
        
        sender.backgroundColor = AppColors.secondaryPurple
        
        selectedDurationButton = sender
        
        print("Selected duration: \(sender.currentTitle ?? "")")
        
        
        saveSettings()
    }
}

//#Preview {
//    CustomNavigationController(rootViewController:SettingsVC())
//}
