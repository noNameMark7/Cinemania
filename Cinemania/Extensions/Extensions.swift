import UIKit

// MARK: - Fonts

extension UIFont {
    
    static func customFontWith(
        name: String,
        ofSize: CGFloat,
        weight: UIFont.Weight = .regular
    ) -> UIFont? {
        if let customFont = UIFont(
            name: name,
            size: ofSize
        ) {
            return customFont
        } else {
            return .systemFont(
                ofSize: ofSize,
                weight: weight
            )
        }
    }
    
    static func customFont(
        _ font: CustomFont,
        ofSize: CGFloat
    ) -> UIFont? {
        customFontWith(
            name: font.fontName,
            ofSize: ofSize
        )
    }
}


// MARK: - Image

extension UIImage {
    
    static func placeholder(named: String) -> UIImage? {
        UIImage(named: named) ?? UIImage(systemName: "photo")
    }
}


// MARK: - Media

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
        self.releaseDate = FormattingReleaseDateValue.convertToYearFormat(model.releaseDate ?? model.firstAirDate ?? "")
        self.voteAverage = model.voteAverage
        self.voteCount = model.voteCount
    }
}


// MARK: - Insets

class PaddedLabel: UILabel {
    var textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + textInsets.left + textInsets.right,
            height: size.height + textInsets.top + textInsets.bottom
        )
    }
}

