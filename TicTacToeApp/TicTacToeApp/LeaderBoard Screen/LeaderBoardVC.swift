//
//  LeaderBoardVC.swift
//  TicTacToeApp
//
//  Created by Надежда Капацина on 29.09.2024.
//

import UIKit

class LeaderBoardVC: UIViewController {
    
    let leaderboardEmptyImage = UIImageView(image: .historyRobot)
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.background
        title = "Leaderboard"
        
        setupViews()
        constraints()
        settingLabel()
    }
    func setupViews() {
        view.addSubview(leaderboardEmptyImage)
        view.addSubview(label)
        
        leaderboardEmptyImage.translatesAutoresizingMaskIntoConstraints = false
    }
    func constraints() {
        NSLayoutConstraint.activate([
        label.bottomAnchor.constraint(equalTo: leaderboardEmptyImage.topAnchor, constant: -40),
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        leaderboardEmptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        leaderboardEmptyImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func settingLabel() {
        label.text = "No game history\nwith turn on time"
        label.font = .SFProDisplay.medium.size(of: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
    }

}
#Preview {
    CustomNavigationController(rootViewController: LeaderBoardVC())
}
