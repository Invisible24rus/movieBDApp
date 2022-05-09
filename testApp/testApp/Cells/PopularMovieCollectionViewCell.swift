//
//  PopularMovieCollectionViewCell.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import UIKit

class PopularMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PopularMovieCollectionViewCell"
    
    private let moviePosterImage: MyImageView = {
        let image = MyImageView()
        image.contentMode = .scaleToFill
        image.backgroundColor = .red
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubviewForAutoLayout(moviePosterImage)
        
        NSLayoutConstraint.activate([
            moviePosterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func cellConfig(_ movie: Movie) {
        moviePosterImage.setImage(movie.poster, placeholder: UIImage(systemName: "umbrella"))
    }
    
}
