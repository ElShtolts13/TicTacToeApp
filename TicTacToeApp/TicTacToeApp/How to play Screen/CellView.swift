//
//  CellView.swift
//  TicTacToeApp
//
//  Created by Сергей Сухарев on 30.09.2024.
//

import UIKit

final class CellView: UIView {
    
    let label = UILabel()
    let textView = UITextView()
    
    init(number: Int, text: String) {
        super.init(frame: .zero)
        
        label.text = String(number)
        textView.text = text
        
        setupViews()
        setupConstraints()
        configuration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(label)
        addSubview(textView)
    }
    
    func configuration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        label.backgroundColor = AppColors.secondaryPurple
        label.textColor = AppColors.basicBlack
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.layer.cornerRadius = 45 / 2
        label.layer.masksToBounds = true
        
        textView.backgroundColor = AppColors.basicLightBlue
        textView.textColor = AppColors.basicBlack
        textView.textContainer.lineFragmentPadding = 24
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.setContentCompressionResistancePriority(.required, for: .vertical)
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        textView.isEditable = false
        textView.layer.cornerRadius = 30
        textView.layer.masksToBounds = true
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 45),
            label.widthAnchor.constraint(equalToConstant:  45),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),

            textView.topAnchor.constraint(equalTo: topAnchor),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
#Preview {
    CellView(number: 2, text: "niihiфывфывфывфвыфвфвыфывфвфывфвыфывфывфывфвhiuhiuhui")
}
