//
//  MovieInfoViewController.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 09.05.2022.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    let movieModel: Movie
    
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
        image.layer.cornerRadius = 10
        return image
    }()
    
    private var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Добро dsadsadasdasdsadasd asdasd asd asd asd asd sad "
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.numberOfLines = 10
        return label
    }()
    
    private var movieDateRealseLabel: UILabel = {
        let label = UILabel()
        label.text = "30.08.2020"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    private var movieScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "5.45"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private var movieInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences."
        label.sizeToFit()
        label.numberOfLines = 10
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
    }
}


private extension MovieInfoViewController {
    
    func setupViews() {
        view.backgroundColor = .systemGray5
        
        view.addSubviewsForAutoLayout([moviePosterImage, movieNameLabel, movieDateRealseLabel, movieScoreLabel, movieInfoLabel])
        
        NSLayoutConstraint.activate([
            moviePosterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
//            movieInfoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
