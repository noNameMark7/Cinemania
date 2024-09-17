import Foundation

// MARK: - Media Extension

extension Media {
    
    init(from model: MediaResult) {
        self.backdrop = model.backdropPath ?? ""
        self.id = model.id
        self.title = model.title ?? model.name ?? ""
        self.poster = model.posterPath ?? ""
        self.overview = model.overview
        self.typeOfMedia = model.typeOfMedia
        self.genre = model.genreIDS ?? []
        self.popularity = model.popularity
        self.releaseDate = ValueFormatting.formattingPerMonthDateYear(model.releaseDate ?? model.firstAirDate ?? "")
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
}
