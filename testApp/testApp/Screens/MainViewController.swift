//
//  ViewController.swift
//  testApp
//
//  Created by NIKITA NIKOLICH on 08.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    var items: [Movie] = []
    var searchItems: [Movie] = []
    
    private let movieSearchController = UISearchController(searchResultsController: nil)
    
    private var popularMovieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.minimumLineSpacing = 15
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PopularMovieCollectionViewCell.self, forCellWithReuseIdentifier: PopularMovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let searchMovieListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .singleLine
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SearchMovieTableViewCell.self, forCellReuseIdentifier: SearchMovieTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchMovieListTableView.dataSource = self
        searchMovieListTableView.delegate = self
        popularMovieCollectionView.dataSource = self
        popularMovieCollectionView.delegate = self
        movieSearchController.searchBar.delegate = self
        networkService.fetchMovie(page: 1) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let popularMovies):
                    self.items += popularMovies.results
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.popularMovieCollectionView.reloadData()
            }
        }
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
            popularMovieCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            popularMovieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            popularMovieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            popularMovieCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            searchMovieListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchMovieListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchMovieListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchMovieListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

//MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchMovieListTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchMovieListTableView.isHidden = true
        searchItems = []
        searchMovieListTableView.reloadData()
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            return
        } else {
            networkService.searchMovie(query: text) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let searchMovie):
                        self.searchItems = []
                        self.searchItems += searchMovie.results
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    self.searchMovieListTableView.reloadData()
                }
            }
        }
    }
}

//MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchMovieTableViewCell.identifier, for: indexPath)
        if let cell = cell as? SearchMovieTableViewCell {
            cell.cellConfig(searchItems[indexPath.row])
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = searchItems[indexPath.row]
        let movieInfoViewController = MovieInfoViewController(movieModel: movie)
        present(movieInfoViewController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCollectionViewCell.identifier, for: indexPath)
        if let cell = cell as? PopularMovieCollectionViewCell {
            cell.cellConfig(items[indexPath.row])
        }
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = items[indexPath.row]
        let movieInfoViewController = MovieInfoViewController(movieModel: movie)
        present(movieInfoViewController, animated: true, completion: nil)
    }
}
