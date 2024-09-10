import UIKit

// MARK: - DetailsViewModelDelegate

protocol DetailsViewModelDelegate: AnyObject {
    
    func updateUI(with model: Media, and genres: [Genre])
    func updateTrailer(with trailerURL: URL?)
}
