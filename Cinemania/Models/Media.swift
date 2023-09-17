import UIKit

struct Media {
    var backdrop: String
    var id: Int
    var title: String
    var poster: String
    var overview: String
    var typeOfMedia: TypeOfMedia
    var genre: [Int]
    var popularity: Double
    var releaseDate: String
    var voteAverage: Double?
    var voteCount: Int

    init(from model: Movies) {
        self.backdrop = model.backdropPath
        self.id = model.id
        self.title = model.title
        self.poster = model.posterPath
        self.overview = model.overview
        self.typeOfMedia = .movie
        self.genre = model.genreIDS
        self.popularity = model.popularity
        self.releaseDate = ValueFormatting.convertDateFormat(model.releaseDate)
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
    
    init(from model: TVShows) {
        self.backdrop = model.backdropPath
        self.id = model.id
        self.title = model.name
        self.poster = model.posterPath
        self.overview = model.overview
        self.typeOfMedia = .tv
        self.genre = model.genreIDS
        self.popularity = model.popularity
        self.releaseDate = ValueFormatting.convertDateFormat(model.firstAirDate)
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
    
    init(from model: MediaRealm) {
        self.backdrop = model.backdrop
        self.id = model.id
        self.title = model.title
        self.poster = model.poster
        self.overview = model.overview
        self.typeOfMedia = model.typeOfMedia
        self.genre = Array(model.genre)
        self.popularity = model.popularity
        self.releaseDate = model.releaseDate
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
}
