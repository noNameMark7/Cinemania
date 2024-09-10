import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import RealmSwift

// MARK: - DetailsView

class DetailsView: UIView {
    
    // MARK: - Properties
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Overview"
        label.font = .customFont(.manropeMedium, ofSize: 18)
        return label
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trailer"
        label.font = .customFont(.manropeMedium, ofSize: 18)
        return label
    }()
   
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultBackdrop")
        return imageView
    }()
    
    private let backdropOverlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultPoster")
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeMedium, ofSize: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 13)
        return label
    }()
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 13)
        return label
    }()
    
    private let voteCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 13)
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeMedium, ofSize: 14)
        return label
    }()
    
    private let tmdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "TMDBLogo")
        return imageView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .customFont(.manropeMedium, ofSize: 14)
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
        playerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add link into overviewTextView and show message if overview is missing
    
    private func configureMissingDescription() {
        let defaultText = "We don't have an overview translated in English, apologize for this. We recommend visiting https://www.themoviedb.org/ to find the content you need. Thank you for understanding."
        let attributedText = NSMutableAttributedString(string: defaultText)
        
        /// Determine the text color based on the current color scheme
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
        
        /// Set the determined text color
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
        }).joined(separator: "\(Constants.divider)")
        
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

        /// Find the 'v' query item
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


// MARK: - Initial setup

extension DetailsView {
    
    func initialSetup() {
        configureUI()
    }
    
    func configureUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImageView)
        backdropImageView.addSubview(backdropOverlayView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewTextView)
        contentView.addSubview(trailerLabel)
        contentView.addSubview(playerView)

//        let horizontalStackView = UIStackView(
//            arrangedSubviews: [
//                tmdbImageView,
//                voteAverageLabel
//            ]
//        )
//        horizontalStackView.axis = .horizontal
//        horizontalStackView.spacing = 8
//        horizontalStackView.alignment = .center
//        horizontalStackView.distribution = .fill /// Use .fill to ensure proper space distribution
//        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        let verticalStackView = UIStackView(
//            arrangedSubviews: [
//                titleLabel,
//                releaseDateLabel,
//                popularityLabel,
//                voteCountLabel,
//                horizontalStackView
//            ]
//        )
//        verticalStackView.axis = .vertical
//        verticalStackView.spacing = 13
//        verticalStackView.alignment = .leading
//        verticalStackView.distribution = .fill /// Ensures even distribution
//        verticalStackView.translatesAutoresizingMaskIntoConstraints = false

        //contentView.addSubview(verticalStackView)
        
        
        
        //contentView.addSubview(releaseDateLabel)
        //contentView.addSubview(popularityLabel)
        //contentView.addSubview(voteCountLabel)
        
        

        // Debugging: Set background colors to visualize layout
        //verticalStackView.backgroundColor = .red.withAlphaComponent(0.3)
        //horizontalStackView.backgroundColor = .green.withAlphaComponent(0.3)
        
        //releaseDateLabel.backgroundColor = .white.withAlphaComponent(0.3)
        //popularityLabel.backgroundColor = .white.withAlphaComponent(0.3)
        //voteCountLabel.backgroundColor = .white.withAlphaComponent(0.3)

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
            backdropImageView.heightAnchor.constraint(equalToConstant: 208)
        ]

        let backdropOverlayViewConstraints = [
            backdropOverlayView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            backdropOverlayView.topAnchor.constraint(equalTo: backdropImageView.topAnchor, constant: -1),
            backdropOverlayView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
            backdropOverlayView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 1)
        ]

        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            posterImageView.widthAnchor.constraint(equalToConstant: 86)
        ]

//        let horizontalStackViewConstraints = [
//            horizontalStackView.widthAnchor.constraint(equalToConstant: 100),
//            horizontalStackView.heightAnchor.constraint(equalToConstant: 21.8)
//        ]
//
//        let verticalStackViewConstraints = [
//            verticalStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
//            verticalStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
//            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            verticalStackView.heightAnchor.constraint(equalTo: posterImageView.heightAnchor)
//        ]

        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        
//        let tmdbImageViewConstraints = [
//            tmdbImageView.widthAnchor.constraint(equalToConstant: 42),
//            tmdbImageView.heightAnchor.constraint(equalToConstant: 21.8)
//        ]
//
        let genreLabelConstraints = [
            genreLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ]

        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]

        let overviewTextViewConstraints = [
            overviewTextView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 12),
            overviewTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ]

        let trailerLabelConstraints = [
            trailerLabel.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: 26),
            trailerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ]

        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 40),
            playerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            playerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16),
            playerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(backdropImageViewConstraints)
        NSLayoutConstraint.activate(backdropOverlayViewConstraints)
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
        //NSLayoutConstraint.activate(verticalStackViewConstraints)
        //NSLayoutConstraint.activate(horizontalStackViewConstraints)
        //NSLayoutConstraint.activate(tmdbImageViewConstraints)
       
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(overviewTextViewConstraints)
        NSLayoutConstraint.activate(trailerLabelConstraints)
        NSLayoutConstraint.activate(playerViewConstraints)

        scrollView.contentSize = contentView.bounds.size
    }
}

// MARK: - DetailsViewModelDelegate

extension DetailsView: DetailsViewModelDelegate {
    
    func updateUI(with model: Media, and genres: [Genre]) {
        configure(with: model, and: genres)
    }
}
