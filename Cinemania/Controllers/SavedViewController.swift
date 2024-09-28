import UIKit

// MARK: - SavedViewController

class SavedViewController: UIViewController {
    
    private let savedView = SavedView()
    private let savedViewModel = SavedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchingAndUpdatingUI()
        navigationItem.backButtonTitle = "Back"
    }
}


// MARK: - Initial setup

extension SavedViewController {
    
    func initialSetup() {
        configureUI()
        configureTableView()
    }
    
    func configureUI() {
        view.addSubview(savedView)
        savedView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            savedView.topAnchor.constraint(equalTo: view.topAnchor),
            savedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            savedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            savedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func fetchingAndUpdatingUI() {
        savedViewModel.fetchAllGenres()
        
        savedViewModel.updateUI = { [weak self] in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                strongSelf.savedView.tableView.reloadData()
            }
        }
    }
}


// MARK: - TableView setup

extension SavedViewController {
    
    func configureTableView() {
        savedView.tableView.dataSource = self
        savedView.tableView.delegate = self
        savedView.tableView.register(
            CustomTableViewCell.self,
            forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier
        )
    }
}


// MARK: - UITableViewDataSource and UITableViewDelegate setup

extension SavedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        savedViewModel.numberOfItems
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
        if let mediaRealm = savedViewModel.getItem(at: indexPath.row) {
            cell.configureWith(mediaRealm, and: savedViewModel.genres)
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        savedViewModel.cellHeight
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let savedMedia = savedViewModel.savedMedia?[indexPath.row] {
            let media = Media(from: savedMedia)
            AppRouter.shared.navigateToDetails(
                from: self,
                media: media,
                genres: savedViewModel.genres
            )
        }
    }
    
    // Deleting a cell by swipe from right to left
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "Remove from saved"
        ) { [weak self] (action, view, completion) in
            guard let self = self else { return }
            let deleteMedia = self.savedViewModel.getItem(at: indexPath.row)
            
            // Deletion confirmation
            let alert = UIAlertController(
                title: "Remove",
                message: "Are you sure you want to remove \(deleteMedia?.title ?? "Unknown title")?",
                preferredStyle: .alert
            )
            
            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .cancel
            ) { _ in
                completion(false)
            }
            
            let confirmDeleteAction = UIAlertAction(
                title: "Remove",
                style: .destructive
            ) { _ in
                // Delete the media using the RealmService
                if let mediaID = deleteMedia?.id {
                    RealmService.shared.deleteMedia(mediaID)
                }
                
                // Delete the row from the table view
                self.savedView.tableView.deleteRows(
                    at: [indexPath],
                    with: .fade
                )
                completion(true)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(confirmDeleteAction)
            self.present(alert, animated: true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "minus.circle")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
