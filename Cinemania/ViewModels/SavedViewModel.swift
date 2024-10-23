import UIKit
import RealmSwift

class SavedViewModel {
    
    var savedMedia: Results<MediaRealm>?
    var genres: [Genre] = []
    private var realm: Realm?
    var updateUI: (() -> Void)?

    init() {
        do {
            realm = try Realm()
        } catch {
            print("Error initializing Realm: \(error)")
        }
        savedMedia = realm?.objects(MediaRealm.self)
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
    
    var numberOfItems: Int {
        savedMedia?.count ?? 0
    }
    
    var cellHeight: CGFloat {
        200
    }
    
    func getItem(at index: Int) -> MediaRealm? {
        savedMedia?[index]
    }
}
