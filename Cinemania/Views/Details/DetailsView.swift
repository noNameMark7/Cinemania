import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import RealmSwift

class DetailsView: UIView {
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = .customFont(.comfortaaSemiBold, ofSize: 20)
        return label
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trailer"
        label.font = .customFont(.comfortaaSemiBold, ofSize: 20)
        return label
    }()
   
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultBackdrop")
        return imageView
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultPoster")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.comfortaaMedium, ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.comfortaaSemiBold, ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let tmdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "TMDBLogo")
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeMedium, ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .customFont(.manropeRegular, ofSize: 13)
        label.numberOfLines = 0
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .clear
        textView.font = .customFont(.manropeRegular, ofSize: 16)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()

    private let playerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.backgroundColor = .black
        return playerView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
 
    private let backdropOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return view
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        settingUIElementsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func settingUIElementsAndConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImageView)
        backdropImageView.addSubview(backdropOverlayView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(genreLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewTextView)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(trailerLabel)
        contentView.addSubview(playerView)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(voteCountLabel)
        contentView.addSubview(tmdbImageView)
        contentView.addSubview(voteAverageLabel)
      
        let scrollViewConstraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ]
        
        let backdropImageViewConstraints = [
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 400)
        ]
        
        let overlayViewContraints = [
            backdropOverlayView.topAnchor.constraint(equalTo: backdropImageView.topAnchor),
            backdropOverlayView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            backdropOverlayView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor),
            backdropOverlayView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor)
        ]
        
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.heightAnchor.constraint(equalToConstant: 220),
            posterImageView.widthAnchor.constraint(equalToConstant: 140)
        ]
        
        let genreLabelConstraints = [
            genreLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 40),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let releaseDateLabelConstraints = [
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20), //
            releaseDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        
        let overviewTextViewConstraints = [
            overviewTextView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            overviewTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let trailerLabelConstraints = [
            trailerLabel.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: 30),
            trailerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]
        
        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 50),
            playerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16),
            playerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
      
        let popularityLabelConstraints = [
            popularityLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            popularityLabel.bottomAnchor.constraint(equalTo: voteCountLabel.topAnchor, constant: -20)
        ]
       
        let voteCountLabelConstraints = [
            voteCountLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            voteCountLabel.bottomAnchor.constraint(equalTo: voteAverageLabel.topAnchor, constant: -24)
        ]
       
        let tmdbImageViewConstraints = [
            tmdbImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            tmdbImageView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            tmdbImageView.widthAnchor.constraint(equalToConstant: 42),
            tmdbImageView.heightAnchor.constraint(equalToConstant: 21.8)
        ]
        
        let voteAverageLabelConstraints = [
            voteAverageLabel.leadingAnchor.constraint(equalTo: tmdbImageView.trailingAnchor, constant: 8),
            voteAverageLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -1.8)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(backdropImageViewConstraints)
        NSLayoutConstraint.activate(overlayViewContraints)
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(overviewTextViewConstraints)
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
        NSLayoutConstraint.activate(trailerLabelConstraints)
        NSLayoutConstraint.activate(playerViewConstraints)
        NSLayoutConstraint.activate(popularityLabelConstraints)
        NSLayoutConstraint.activate(voteCountLabelConstraints)
        NSLayoutConstraint.activate(tmdbImageViewConstraints)
        NSLayoutConstraint.activate(voteAverageLabelConstraints)
        
        scrollView.contentSize = contentView.bounds.size
    }
    
    // MARK: - Add link into overviewTextView and show message if overview is missing
    private func configureMissingDescription() {
        let defaultText = "We don't have an overview translated in English, apologize for this. We recommend visiting https://www.themoviedb.org/ to find the content you need. Thank you for understanding."
        let attributedText = NSMutableAttributedString(string: defaultText)
        
        // Determine the text color based on the current color scheme
        let textColor: UIColor = {
            if self.traitCollection.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }()
        
        attributedText.addAttribute(
            .font,
            value: UIFont.customFont(.manropeRegular, ofSize: 16) as Any,
            range: NSMakeRange(0, attributedText.length)
        )
        
        let linkRange = (defaultText as NSString).range(of: "https://www.themoviedb.org/")
        attributedText.addAttribute(
            .link,
            value: "https://www.themoviedb.org/",
            range: linkRange
        )
        
        attributedText.addAttribute(
            .underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: linkRange
        )
        
        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.blue,
            range: linkRange
        )
        
        // Set the determined text color
        attributedText.addAttribute(
            .foregroundColor,
            value: textColor,
            range: NSMakeRange(0, attributedText.length)
        )
        
        overviewTextView.attributedText = attributedText
        overviewTextView.isUserInteractionEnabled = true
        overviewTextView.isSelectable = true
        overviewTextView.isEditable = false
    }
    
    func configure(with object: Media, and genres: [Genre]) {
        if let backdropURL = URL(string: Constants.getImage + object.backdrop) {
            backdropImageView.sd_setImage(with: backdropURL, placeholderImage: .placeholder(named: "DefaultBackdrop"))
        } else {
            backdropImageView.image = .placeholder(named: "DefaultBackdrop")
        }
        
        if let posterURL = URL(string: Constants.getImage + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        genreLabel.text = object.genre.compactMap({ genreID in
            genres.first { $0.id == genreID }?.name
        }).joined(separator: ", ")
        
        titleLabel.text = object.title
        
        object.overview.isEmpty ? configureMissingDescription() : { overviewTextView.text = object.overview }()
        
        releaseDateLabel.text = "\(object.releaseDate)"
        
        popularityLabel.text = "Popularity: \(object.popularity)"
        
        voteCountLabel.text = "Vote count: \(object.voteCount)"
        
        let formattedVoteAverage = ValueFormatting.formatVoteAverage(object.voteAverage)
        voteAverageLabel.text = formattedVoteAverage
    }
    
    // MARK: - Extract video ID
    private func extractVideoId(from trailerUrl: URL) -> String? {
        guard let queryItems = URLComponents(
            url: trailerUrl,
            resolvingAgainstBaseURL: true
        )?.queryItems else {
            return nil
        }

        // Find the 'v' query item
        guard let vQueryItem = queryItems.first(where: { $0.name == "v" }), let videoId = vQueryItem.value else {
            return nil
        }
        return videoId
    }
    
    // MARK: - Show message if trailer is missing
    private func showMessageIfTrailerIsMissing() {
        let text = "Unfortunately, there is no trailer, sorry.. If the trailer appears on our website, it will immediately appear here."
        let components = text.components(separatedBy: ". ")
        let label = UILabel()
        label.text = components.joined(separator: "\n")
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .customFont(.manropeRegular, ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false

        playerView.addSubview(label)
        
        let labelConstraints = [
            label.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
            label.centerXAnchor.constraint(equalTo: playerView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(labelConstraints)
    }
    
    // MARK: - Update the trailer in the player view
    func updateTrailer(with trailerURL: URL?) {
        if let trailerURL = trailerURL {
            self.playerView.load(
                withVideoId: extractVideoId(from: trailerURL) ?? "",
                playerVars: ["playsinline": 1]
            )
        } else {
            showMessageIfTrailerIsMissing()
        }
    }
}

extension DetailsView: DetailsViewModelDelegate {
    func updateUI(with model: Media, and genres: [Genre]) {
        configure(with: model, and: genres)
    }
}
