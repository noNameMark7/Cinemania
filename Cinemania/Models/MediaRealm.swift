import UIKit
import RealmSwift

class MediaRealm: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var poster: String
    @Persisted var title: String
    @Persisted var genre = List<Int>()
    @Persisted var voteAverage: Double?
    @Persisted var typeOfMedia: TypeOfMedia
    @Persisted var backdrop: String
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var releaseDate: String
    @Persisted var voteCount: Int
}
