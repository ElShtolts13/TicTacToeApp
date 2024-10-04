//
//  SettingVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    var selectedButtonIndex: Int? = nil
    var buttons: [UIButton] = [] //первая кнопка не сбрасывалась
    
    let imageNames = [
        "Cross", "Nought",
        "CrossWithBg", "NoughtWithBg",
        "Pie", "IceCream",
        "CrossYelow", "NoughtGreen",
        "Star", "Heart",
        "Burger", "FrenchFries"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        
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
                   //lowerStackView.heightAnchor.constraint(equalToConstant: 500)
               ])
        
        // MARK: Добавляем блоки наверх
        let upperTitles = ["Game Time", "Duration", "Music", "Select Music"]
        for title in upperTitles {
            let blockView = createUpperBlock(title: title)
            upperStackView.addArrangedSubview(blockView)
            
            blockView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                blockView.leadingAnchor.constraint(equalTo: upperStackView.leadingAnchor, constant: 20),
                blockView.trailingAnchor.constraint(equalTo: upperStackView.trailingAnchor, constant: -20),
                // blockView.topAnchor.constraint(equalTo: upperStackView.topAnchor, constant: 20),
                // blockView.bottomAnchor.constraint(equalTo: upperStackView.bottomAnchor, constant: -20),
            ])
        }
        
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
    }
    
    // MARK: Функция для блоков наверху
    func createUpperBlock(title: String) -> UIView {
        let blockView = UIView()
        blockView.backgroundColor = AppColors.basicLightBlue
        blockView.layer.cornerRadius = 30
        blockView.translatesAutoresizingMaskIntoConstraints = false
            
        blockView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        //blockView.isLayoutMarginsRelativeArrangement = true
            
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.text = title
            
        let contentStack: UIStackView
            
        if title == "Game Time" || title == "Music" {
            let switchControl = UISwitch()
            switchControl.isOn = false
            switchControl.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            switchControl.onTintColor = AppColors.basicBlue

            contentStack = UIStackView(arrangedSubviews: [titleLabel, switchControl])
            contentStack.axis = .horizontal
            contentStack.spacing = 10
            contentStack.alignment = .center
        } else {
            contentStack = UIStackView(arrangedSubviews: [titleLabel])
            contentStack.axis = .vertical
            contentStack.spacing = 10
            contentStack.alignment = .leading
        }
        
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        blockView.addSubview(contentStack)
        
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: blockView.layoutMarginsGuide.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: blockView.layoutMarginsGuide.trailingAnchor),
            contentStack.topAnchor.constraint(equalTo: blockView.layoutMarginsGuide.topAnchor),
            contentStack.bottomAnchor.constraint(equalTo: blockView.layoutMarginsGuide.bottomAnchor)
        ])
        
        return blockView
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
    
    // MARK: Логика нажатия кнопки
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
    }
    
    @objc func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            print("Switch is ON")
        } else {
            print("Switch is OFF")
        }
    }
}

#Preview {
    SettingsVC()
}
