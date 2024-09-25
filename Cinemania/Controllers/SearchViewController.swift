import UIKit

// MARK: - SearchViewController

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private var media: [Media] = []
    private var genres: [Genre] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.reuseIdentifier
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gettingGenres()
    }
}


// MARK: - Initial setup

extension SearchViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        configureUI()
        setupSearchController()
        setupCollectionView()
    }
    
    func configureUI() {
        view.addSubview(collectionView)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - Fetching

extension SearchViewController {
    
    func gettingGenres() {
        NetworkService.shared.fetchAllGenres { [weak self] response in
            switch response {
            case .success(let genres):
                self?.genres = genres
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching genres: \(error.localizedDescription)")
            }
        }
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return media.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: media[indexPath.item])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        AppRouter.shared.navigateToDetails(
            from: self,
            media: media[indexPath.item],
            genres: genres
        )
    }
    
    // Handling long press and save
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil
        ) { _ in

            let saveAction = UIAction(
                title: "Save",
                image: UIImage(systemName: "square.and.arrow.down")
            ) { [weak self] _ in
                
                guard let strongSelf = self else { return }
                
                // Convert movies to media object
                let media = strongSelf.media[indexPath.item]
                
                // Checking id if item already exist before saving
                if RealmService.shared.isMediaSaved(media.id) {
                    // Alert message if media already exsist
                    let alert = UIAlertController(
                        title: "Saved",
                        message: "\(media.title) already saved.",
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(
                        title: "OK",
                        style: .default
                    )
                    
                    alert.addAction(okAction)
                    strongSelf.present(alert, animated: true)
                } else {
                    // If not - save
                    RealmService.shared.saveMedia(media)
                    
                    let alert = UIAlertController(
                        title: "Success",
                        message: "\(media.title) successfully saved!",
                        preferredStyle: .alert
                    )
                    
                    let okAction = UIAlertAction(
                        title: "OK",
                        style: .default
                    )
                    
                    alert.addAction(okAction)
                    strongSelf.present(alert, animated: true)
                } 
            }

            return UIMenu(
                children: [saveAction]
            )
        }
    }
}


// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 2 else {
            return
        }
        
        // Start the search request
        NetworkService.shared.universalSearch(with: query) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let media):
                    self?.media = media
                    self?.collectionView.reloadData()
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
    }
}


// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        removeMoviesAfterCanceling()
    }
    
    func removeMoviesAfterCanceling() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.media = []
            strongSelf.collectionView.reloadData()
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        // Calculate the total horizontal space for the collectionView's section insets and inter-item spacing
        let totalHorizontalSpace = SECTION_INSETS.left + SECTION_INSETS.right + (HORIZONTAL_SPACING * (NUMBER_OF_CELLS_PER_ROW - 1))
        
        // Calculate the width available for each cell
        let availableWidth = collectionView.bounds.width - totalHorizontalSpace
        let cellWidth = availableWidth / NUMBER_OF_CELLS_PER_ROW
        
        // Maintain the 1.5 aspect ratio (height = 1.5 * width)
        let cellHeight = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        
        // Adjust the edge insets to reduce space from display edges
        UIEdgeInsets(
            top: SECTION_INSETS.top,
            left: SECTION_INSETS.left,
            bottom: SECTION_INSETS.bottom,
            right: SECTION_INSETS.right
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        HORIZONTAL_SPACING
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        VERTICAL_SPACING
    }
}
