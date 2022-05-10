//
//  MovieInfoViewController.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    let movieModel: Movie
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    init(movieModel: Movie) {
        self.movieModel = movieModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let moviePosterImage: MyImageView = {
        let image = MyImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    private var movieDateRealseLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private var movieScoreLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private var movieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.sizeToFit()
        label.numberOfLines = 100
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupModel()

    }
    
    func setupModel() {
        moviePosterImage.setImage(movieModel.poster)
        movieNameLabel.text = movieModel.movieName
        movieDateRealseLabel.text = movieModel.releaseDate
        movieScoreLabel.text = "\(movieModel.voteAverage)"
        movieInfoLabel.text = movieModel.overview
    }
}

private extension MovieInfoViewController {
    
    func setupViews() {
        view.backgroundColor = .systemGray5
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubviewForAutoLayout(scrollView)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubviewsForAutoLayout([moviePosterImage, movieNameLabel, movieDateRealseLabel, movieScoreLabel, movieInfoLabel])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            moviePosterImage.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            moviePosterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            moviePosterImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            moviePosterImage.heightAnchor.constraint(equalToConstant: 300),
            
            movieNameLabel.topAnchor.constraint(equalTo: moviePosterImage.bottomAnchor,constant: 20),
            movieNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            movieDateRealseLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 5),
            movieDateRealseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            movieScoreLabel.topAnchor.constraint(equalTo: movieDateRealseLabel.bottomAnchor, constant: 5),
            movieScoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            movieInfoLabel.topAnchor.constraint(equalTo: movieScoreLabel.bottomAnchor, constant: 20),
            movieInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            movieInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            movieInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
