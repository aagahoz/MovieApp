//
//  MovieCell.swift
//  MovieApp
//
//  Created by Agah on 7.04.2026.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let overviewLabel = UILabel()
    private let posterImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        overviewLabel.text = nil
        posterImageView.image = nil
        posterImageView.cancelImageLoad()
    }
    
    private func setupUI() {
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true

        contentView.addSubview(posterImageView)
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        overviewLabel.font = .systemFont(ofSize: 12)
        overviewLabel.numberOfLines = 2
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, overviewLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 60),
            posterImageView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo:  contentView.bottomAnchor, constant: -8)
            
        ])
  
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        posterImageView.image = UIImage(systemName: "photo")
        posterImageView.setImage(with: movie.posterURL)
    }
    
}
