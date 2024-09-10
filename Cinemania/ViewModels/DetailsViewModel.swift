import UIKit

// MARK: - DetailsViewModel

class DetailsViewModel {
    
    var media: Media?
    var genres: [Genre] = []
    var trailerURL: URL?
    var trailerURLCache: [Int: URL] = [:]
    weak var delegate: DetailsViewModelDelegate?

    init(media: Media? = nil, genres: [Genre]) {
        self.media = media
        self.genres = genres
    }
        
    func fetchMediaDetails() {
        guard let media = media else { return }
        /// Update the UI with other media details
        delegate?.updateUI(with: media, and: genres)
        
        if let cachedTrailerURL = trailerURLCache[media.id] {
            DispatchQueue.main.async {
                /// Use the cached trailer URL
                self.trailerURL = cachedTrailerURL
                self.delegate?.updateTrailer(with: cachedTrailerURL)
            }
        } else {
            /// Load the trailer URL from the network
            NetworkService.shared.loadTrailer(
                media.typeOfMedia,
                media.id
            ) { [weak self] trailerURL in
                DispatchQueue.main.async {
                    self?.trailerURL = trailerURL
                    self?.trailerURLCache[media.id] = trailerURL
                    self?.delegate?.updateTrailer(with: trailerURL)
                }
            }
        }
    }
}
