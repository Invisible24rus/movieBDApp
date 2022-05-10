//
//  SearchMovieTableViewCell.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 10.05.2022.
//

import UIKit

class SearchMovieTableViewCell: UITableViewCell {
    
    static let identifier = "SearchMovieTableViewCell"
    
    private let moviePosterImage: MyImageView = {
        let image = MyImageView()
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "4324234"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private var movieDateRealseLabel: UILabel = {
        let label = UILabel()
        label.text = "5325235"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private var movieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "3213"
        label.sizeToFit()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        contentView.addSubviewsForAutoLayout([moviePosterImage, movieNameLabel, movieDateRealseLabel, movieInfoLabel])
        
        NSLayoutConstraint.activate([
            moviePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            moviePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            moviePosterImage.widthAnchor.constraint(equalToConstant: 150),
            
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            movieNameLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            movieDateRealseLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 5),
            movieDateRealseLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieDateRealseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            movieInfoLabel.topAnchor.constraint(equalTo: movieDateRealseLabel.bottomAnchor, constant: 5),
            movieInfoLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor, constant: 10),
            movieInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    func cellConfig(_ movie: Movie) {
        moviePosterImage.setImage(movie.poster, placeholder: UIImage(systemName: "square.slash.fill"))
        movieNameLabel.text = movie.movieName
        movieDateRealseLabel.text = movie.releaseDate
        movieInfoLabel.text = movie.overview
    }

}
