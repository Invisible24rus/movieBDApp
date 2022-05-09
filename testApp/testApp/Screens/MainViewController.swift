//
//  ViewController.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 08.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let movieSearchController = UISearchController(searchResultsController: nil)
    
    private var popularMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.register(WeatherTempForecastCollectionViewCell.self, forCellWithReuseIdentifier: WeatherTempForecastCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let searchMovieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .purple
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchMovieListTableView.dataSource = self
//        movieSearchController.searchBar.delegate = self
    }

}

//MARK: - Private

private extension MainViewController {
    
    func setupViews() {
        
        title = "Популярное сегодня"
        view.backgroundColor = .systemGray5
        
        view.addSubviewsForAutoLayout([popularMovieCollectionView, searchMovieListTableView])
        
        navigationItem.searchController = movieSearchController
        navigationItem.backButtonTitle = ""
        movieSearchController.searchResultsUpdater = self
        movieSearchController.searchBar.placeholder = "Поиск фильмов"
        movieSearchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        
        NSLayoutConstraint.activate([
            popularMovieCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            popularMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularMovieCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            searchMovieListTableView.topAnchor.constraint(equalTo: popularMovieCollectionView.bottomAnchor),
            searchMovieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchMovieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchMovieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        return cell
    }

}
