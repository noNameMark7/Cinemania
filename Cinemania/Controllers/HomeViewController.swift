import UIKit
import RealmSwift

class HomeViewController: UIViewController, UIScrollViewDelegate {
    private let homeView = HomeView()
    private let homeViewModel = HomeViewModel()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        homeView.segmentedControl.addTarget(
            self,
            action: #selector(segmentedControlValueChanged),
            for: .valueChanged
        )
        
        settingUIElementsAndConstraints()
        
        homeViewModel.fetchInitialData { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.tableView.reloadData()
                self?.homeViewModel.fetchAllGenres()
            }
        }

        homeViewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.tableView.reloadData()
            }
        }
    }
 
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {        
        homeViewModel.segmentedControlValueChanged(index: sender.selectedSegmentIndex)

        let modelType: Codable.Type = homeViewModel.selectedSegment == 0 ? TrendingMovies.self : TrendingTVShows.self
        
        homeViewModel.fetchMedia(
            for: homeViewModel.selectedSegment == 0 ? .movie : .tv,
            modelType: modelType
        ) { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.tableView.reloadData()
            }
        }
    }
 
    private func setupSearchBar() {
        homeViewModel.searchController.searchResultsUpdater = self
        homeViewModel.searchController.obscuresBackgroundDuringPresentation = false
        homeViewModel.searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = homeViewModel.searchController
        definesPresentationContext = true
    }

    private func settingUIElementsAndConstraints() {
        view.addSubview(homeView)
        homeView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: view.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier
        )
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        homeViewModel.searchController.isActive ? homeViewModel.filtered.count : homeViewModel.numberOfItems
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let item = homeViewModel.searchController.isActive ? homeViewModel.filtered[indexPath.row] : homeViewModel.getItem(at: indexPath.row)
        cell.configure(with: item, and: homeViewModel.genres)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        homeViewModel.cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = homeViewModel.getSelectedItem(for: indexPath)
        AppRouter.shared.navigateToDetails(
            from: self,
            media: selectedItem,
            genres: homeViewModel.genres
        )
    }
    
    // Swipe to download
    func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let saveAction = UIContextualAction(
            style: .normal,
            title: "Save"
        ) { [weak self] (_, _, completion) in
            guard let self = self else { return }
            let mediaToSave: Media
            
            if self.homeViewModel.searchController.isActive {
                // If in search mode, get the media from the search results
                mediaToSave = self.homeViewModel.filtered[indexPath.row]
            } else {
                // If not in search mode, get the media from the original data
                mediaToSave = self.homeViewModel.getItem(at: indexPath.row)
            }
            
            // Check if the media is already saved
            let realm = try? Realm()
            if (realm?.object(ofType: MediaRealm.self, forPrimaryKey: mediaToSave.id)) != nil {
                let alert = UIAlertController(
                    title: "Saved",
                    message: "\(mediaToSave.title) already saved.",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(
                    title: "OK",
                    style: .default
                )
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            } else {
                // Create a RealmModel object and save it
                let realmMedia = MediaRealm()
                realmMedia.id = mediaToSave.id
                realmMedia.poster = mediaToSave.poster
                realmMedia.title = mediaToSave.title
                realmMedia.genre.append(objectsIn: mediaToSave.genre)
                realmMedia.voteAverage = mediaToSave.voteAverage
                realmMedia.typeOfMedia = mediaToSave.typeOfMedia
                realmMedia.backdrop = mediaToSave.backdrop
                realmMedia.overview = mediaToSave.overview
                realmMedia.popularity = mediaToSave.popularity
                realmMedia.releaseDate = mediaToSave.releaseDate
                realmMedia.voteCount = mediaToSave.voteCount
                
                try? realm?.write {
                    realm?.add(realmMedia, update: .all)
                }
                
                DispatchQueue.main.async { [weak self] in
                    self?.homeView.tableView.reloadData()
                }
                
                let alert = UIAlertController(
                    title: "Success",
                    message: "\(mediaToSave.title) successfully saved!",
                    preferredStyle: .alert
                )
                
                let okAction = UIAlertAction(
                    title: "OK",
                    style: .default
                )
                
                alert.addAction(okAction)
                self.present(alert, animated: true)
            }
            completion(true)
        }
        
        saveAction.backgroundColor = .systemGreen
        saveAction.image = UIImage(systemName: "arrow.down.to.line.circle")
        let configuration = UISwipeActionsConfiguration(actions: [saveAction])
        return configuration
    }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let tableView = homeView.tableView
        guard let searchText = searchController.searchBar.text,
              !searchText.trimmingCharacters(in: .whitespaces).isEmpty,
              searchText.trimmingCharacters(in: .whitespaces).count >= 3 else {
            homeViewModel.filtered = []
            tableView.reloadData()
            return
        }
        homeViewModel.filtered = homeViewModel.trendingMedia.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        homeViewModel.searchIsActive = false
        homeView.segmentedControlTopConstraint?.constant = 16
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        homeViewModel.searchIsActive = true
        homeView.segmentedControlTopConstraint?.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
}
