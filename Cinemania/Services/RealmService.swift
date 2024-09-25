import UIKit
import RealmSwift

// MARK: - RealmService

final class RealmService {
    
    static let shared = RealmService()
    
    private init() {}
    
    let realm = try? Realm()
    
    // Save a Media object to Realm
    func saveMedia(_ media: Media) {
        guard let realm = realm else { return }
        
        let mediaRealm = MediaRealm()
        mediaRealm.id = media.id
        mediaRealm.poster = media.poster
        mediaRealm.title = media.title
        mediaRealm.genre.append(objectsIn: media.genre)
        mediaRealm.voteAverage = media.voteAverage
        mediaRealm.typeOfMedia = media.typeOfMedia
        mediaRealm.backdrop = media.backdrop
        mediaRealm.overview = media.overview
        mediaRealm.popularity = media.popularity
        mediaRealm.releaseDate = media.releaseDate
        mediaRealm.voteCount = media.voteCount
        
        try? realm.write {
            realm.add(mediaRealm, update: .all)
        }
    }
    
    // Check if a Media object with the given ID is saved in Realm
    func isMediaSaved(_ mediaID: Int) -> Bool {
        guard let realm = realm else {
            return false
        }
        
        return realm.object(ofType: MediaRealm.self, forPrimaryKey: mediaID) != nil
    }
    
    // Delete a Media object with the given ID from Realm
    func deleteMedia(_ mediaID: Int) {
        guard let realm = realm else {
            return
        }
        
        if let mediaToDelete = realm.object(ofType: MediaRealm.self, forPrimaryKey: mediaID) {
            do {
                try realm.write {
                    realm.delete(mediaToDelete)
                }
            } catch {
                print("Error deleting media from Realm: \(error)")
            }
        }
    }
}
