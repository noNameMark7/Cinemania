import UIKit

// MARK: - HomeViewModel

class HomeViewModel {
    
    var trendingMedia: [Media] = []
    var filtered: [Media] = []
    var genres: [Genre] = []
    var selectedSegment: Int = 0
    var searchIsActive: Bool = false
    var updateUI: (() -> Void)?
    
    private var initialDataLoaded = false
   
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()

    func fetchMedia<T: Codable>(
        for mediaType: TypeOfMedia,
        modelType: T.Type,
        completion: @escaping (() -> Void)
    ) {
        NetworkService.shared.fetchTrendingMedia(
            mediaType: mediaType,
            timeWindow: .day,
            modelType: modelType
        ) { [weak self] response in
            switch response {
            case .success(let trendingData):
                if let trendingMovies = trendingData as? TrendingMovies {
                    self?.trendingMedia = trendingMovies.results.map { Media(from: $0) }
                } else if let trendingTVShows = trendingData as? TrendingTVShows {
                    self?.trendingMedia = trendingTVShows.results.map { Media(from: $0) }
                }
                completion()
            case .failure(let error):
                print("Error fetching trending data: \(error.localizedDescription)")
            }
        }
    }
   
    func fetchInitialData(
        completion: @escaping (() -> Void)
    ) {
        if initialDataLoaded {
            /// If data is already loaded, just call the completion block
            completion()
            return
        }
        
        fetchMedia(
            for: .movie,
            modelType: TrendingMovies.self
        ) {
            DispatchQueue.main.async {
                /// Set the flag to true
                self.initialDataLoaded = true
                completion()
            }
        }
    }
    
    func fetchAllGenres() {
        NetworkService.shared.fetchAllGenres { [weak self] response in
            switch response {
            case .success(let genres):
                self?.genres = genres
                self?.updateUI?()
            case .failure(let error):
                print("Error fetching genres: \(error.localizedDescription)")
            }
        }
    }
  
    func segmentedControlValueChanged(index: Int) {
        selectedSegment = index
    }
    
    var numberOfItems: Int {
        trendingMedia.count
    }
    
    var cellHeight: CGFloat {
        200
    }
    
    func getItem(at index: Int) -> Media {
        trendingMedia[index]
    }
    
    func getSelectedItem(for indexPath: IndexPath) -> Media {
        searchController.isActive ? filtered[indexPath.row] : getItem(at: indexPath.row)
    }
}
