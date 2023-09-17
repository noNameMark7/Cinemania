import UIKit
import SafariServices

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
        view.backgroundColor = .systemBackground
        settingUIElementsAndConstraints()
        detailsViewModel.delegate = detailsView
        detailsViewModel.fetchMediaDetails()
    }
    
    private func settingUIElementsAndConstraints() {
        view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: view.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        detailsView.overviewTextView.delegate = self
    }
}

extension DetailsViewController: DetailsViewModelDelegate {
    func updateUI(with model: Media, and genres: [Genre]) {
        detailsView.configure(with: model, and: genres)
    }
    
    func updateTrailer(with trailerURL: URL?) {
        detailsView.updateTrailer(with: trailerURL)
    }
}

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
