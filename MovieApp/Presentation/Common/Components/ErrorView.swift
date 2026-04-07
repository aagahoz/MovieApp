//
//  ErrorView.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import UIKit

final class ErrorView: UIView {
    
    var onRetry: (() -> Void)?
    
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.text = "Something went wrong"
        label.textAlignment = .center
        
        button.setTitle("Retry", for: .normal)
        button.addTarget(self, action: #selector(retryTapped), for: .touchUpInside)
        
        let stack = UIStackView(arrangedSubviews: [label, button])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func retryTapped() {
        onRetry?()
    }
    
}
