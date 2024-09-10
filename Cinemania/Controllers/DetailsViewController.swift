import UIKit
import SafariServices

// MARK: - DetailsViewController

class DetailsViewController: UIViewController {
    
    private let detailsView: DetailsView
    private let detailsViewModel: DetailsViewModel
    
    init(detailsViewModel: DetailsViewModel) {
        self.detailsViewModel = detailsViewModel
        self.detailsView = DetailsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        detailsViewModel.fetchMediaDetails()
    }
}


// MARK: - Initial setup

extension DetailsViewController {
    
    func initialSetup() {
        view.backgroundColor = .systemBackground
        configureUI()
        delegatesSetup()
    }
    
    func configureUI() {
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func delegatesSetup() {
        detailsView.overviewTextView.delegate = self
        detailsViewModel.delegate = detailsView
    }
}


// MARK: - DetailsViewModelDelegate

extension DetailsViewController: DetailsViewModelDelegate {
    
    func updateUI(with model: Media, and genres: [Genre]) {
        detailsView.configure(with: model, and: genres)
    }
    
    func updateTrailer(with trailerURL: URL?) {
        detailsView.updateTrailer(with: trailerURL)
    }
}


// MARK: - UITextViewDelegate

extension DetailsViewController: UITextViewDelegate {
    
    func textView(
        _ textView: UITextView,
        shouldInteractWith URL: URL,
        in characterRange: NSRange
    ) -> Bool {
        let safariVC = SFSafariViewController(url: URL)
        present(safariVC, animated: true)
        return false
    }
}
