import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import RealmSwift

// MARK: - DetailsView

class DetailsView: UIView {
    
    // MARK: - Properties
    
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
   
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultBackdrop")
        imageView.layer.masksToBounds = true
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
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultPoster")
        imageView.layer.borderWidth = 0.8
        imageView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return imageView
    }()
    
    private let releaseDateLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 14)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.borderWidth = 0.8
        label.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.heightAnchor.constraint(equalToConstant: 26).isActive = true
        label.widthAnchor.constraint(equalToConstant: 97).isActive = true
        label.textAlignment = .center
        return label
    }()

    private let spacerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    private let genreLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 13)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    private let tmdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "TMDBLogo")
        return imageView
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 14)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.layer.borderWidth = 0.8
        label.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseBold, ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Contains all properties below
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9647058824, alpha: 1)
        return view
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About"
        label.font = .customFont(.suseSemiBold, ofSize: 22)
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.textColor = .secondaryLabel
        textView.font = .customFont(.suseRegular, ofSize: 15)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = Constants.indentationEightOnAllSides
        return textView
    }()
    
    private let firstSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.18)
        view.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        return view
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trailer"
        label.font = .customFont(.suseSemiBold, ofSize: 22)
        return label
    }()

    private let playerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return playerView
    }()
    
    private let secondSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.18)
        view.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.font = .customFont(.suseSemiBold, ofSize: 22)
        return label
    }()
    
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popularity"
        label.font = .customFont(.suseRegular, ofSize: 12)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let popularityLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseLight, ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let votedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Voted"
        label.font = .customFont(.suseRegular, ofSize: 12)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private let voteCountLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseLight, ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        contentView.addSubview(releaseDateLabelValue)
        contentView.addSubview(spacerView)
        spacerView.addSubview(genreLabelValue)
        contentView.addSubview(tmdbImageView)
        contentView.addSubview(voteAverageLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(overviewTextView)
        containerView.addSubview(firstSeparatorView)
        containerView.addSubview(trailerLabel)
        containerView.addSubview(playerView)
        containerView.addSubview(informationLabel)
        containerView.addSubview(secondSeparatorView)
        containerView.addSubview(popularityLabel)
        containerView.addSubview(popularityLabelValue)
        containerView.addSubview(votedLabel)
        containerView.addSubview(voteCountLabelValue)


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
            backdropImageView.heightAnchor.constraint(equalTo: backdropImageView.widthAnchor, multiplier: 1/1.77)
        ]
        
        let backdropOverlayViewConstraints = [
            backdropOverlayView.topAnchor.constraint(equalTo: backdropImageView.topAnchor),
            backdropOverlayView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor),
            backdropOverlayView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor),
            backdropOverlayView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor)
        ]

        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.heightAnchor.constraint(equalToConstant: 140),
            posterImageView.widthAnchor.constraint(equalToConstant: 93)
        ]
        
        let tmdbImageViewConstraints = [
            tmdbImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            tmdbImageView.widthAnchor.constraint(equalToConstant: 42),
            tmdbImageView.heightAnchor.constraint(equalToConstant: 22),
            tmdbImageView.bottomAnchor.constraint(equalTo: releaseDateLabelValue.topAnchor, constant: -8)
        ]
        
        let voteAverageLabelConstraints = [
            voteAverageLabel.leadingAnchor.constraint(equalTo: tmdbImageView.trailingAnchor, constant: 4),
            voteAverageLabel.centerYAnchor.constraint(equalTo: tmdbImageView.centerYAnchor),
            voteAverageLabel.heightAnchor.constraint(equalTo: tmdbImageView.heightAnchor),
            voteAverageLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 51)
        ]
        
        let releaseDateLabelConstraints = [
            releaseDateLabelValue.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            releaseDateLabelValue.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor)
        ]
        
        let spacerViewConstraints = [
            spacerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            spacerView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            spacerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            spacerView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: -12)
        ]
        
        let genreLabelConstraints = [
            genreLabelValue.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            genreLabelValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            genreLabelValue.centerYAnchor.constraint(equalTo: spacerView.centerYAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 22),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ]
        
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 26),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ]
        
        let aboutLabelConstraints = [
            aboutLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let overviewTextViewConstraints = [
            overviewTextView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 16),
            overviewTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            overviewTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let firstSeparatorViewConstraints = [
            firstSeparatorView.topAnchor.constraint(equalTo: overviewTextView.bottomAnchor, constant: 32),
            firstSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            firstSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let trailerLabelConstraints = [
            trailerLabel.topAnchor.constraint(equalTo: firstSeparatorView.bottomAnchor, constant: 24),
            trailerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 20),
            playerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            playerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9/16)
        ]
        
        let secondSeparatorViewConstraints = [
            secondSeparatorView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 32),
            secondSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            secondSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let informationLabelConstraints = [
            informationLabel.topAnchor.constraint(equalTo: secondSeparatorView.bottomAnchor, constant: 24),
            informationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let popularityLabelConstraints = [
            popularityLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 10),
            popularityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let popularityLabelValueConstraints = [
            popularityLabelValue.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: 3),
            popularityLabelValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let votedLabelConstraints = [
            votedLabel.topAnchor.constraint(equalTo: popularityLabelValue.bottomAnchor, constant: 16),
            votedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let voteCountLabelValueConstraints = [
            voteCountLabelValue.topAnchor.constraint(equalTo: votedLabel.bottomAnchor, constant: 3),
            voteCountLabelValue.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            voteCountLabelValue.bottomAnchor.constraint(equalTo: containerView.layoutMarginsGuide.bottomAnchor, constant: -16)
        ]

        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(backdropImageViewConstraints)
        NSLayoutConstraint.activate(backdropOverlayViewConstraints)
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(releaseDateLabelConstraints)
        NSLayoutConstraint.activate(spacerViewConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
        NSLayoutConstraint.activate(tmdbImageViewConstraints)
        NSLayoutConstraint.activate(voteAverageLabelConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(aboutLabelConstraints)
        NSLayoutConstraint.activate(overviewTextViewConstraints)
        NSLayoutConstraint.activate(firstSeparatorViewConstraints)
        NSLayoutConstraint.activate(trailerLabelConstraints)
        NSLayoutConstraint.activate(playerViewConstraints)
        NSLayoutConstraint.activate(secondSeparatorViewConstraints)
        NSLayoutConstraint.activate(informationLabelConstraints)
        NSLayoutConstraint.activate(popularityLabelConstraints)
        NSLayoutConstraint.activate(popularityLabelValueConstraints)
        NSLayoutConstraint.activate(votedLabelConstraints)
        NSLayoutConstraint.activate(voteCountLabelValueConstraints)

        scrollView.contentSize = contentView.bounds.size
    }
}


// MARK: - Text processing in UITextView

private extension DetailsView {
    
    /// Add link into overviewTextView and show message if overview is missing
    func configureMissingDescription() {
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
            value: UIFont.customFont(.suseRegular, ofSize: 16) as Any,
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
    
    /// Show message if trailer is missing
    func showMessageIfTrailerIsMissing() {
        let text = "😥\nUnfortunately, there is no trailer, sorry.. If the trailer appears on our website, it will immediately appear here."
        let components = text.components(separatedBy: ". ")
        let label = UILabel()
        label.text = components.joined(separator: "\n")
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.customFont(.suseRegular, ofSize: 18)
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
}


// MARK: - Video processing

extension DetailsView {
    
    /// Extract video ID
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
    
    /// Update the trailer in the player view
    public func updateTrailer(with trailerURL: URL?) {
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


// MARK: - Cell configuration

extension DetailsView {

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
        
        genreLabelValue.text = object.genre.compactMap({ genreID in
            genres.first { $0.id == genreID }?.name
        }).joined(separator: "\(Constants.divider)")
        
        titleLabel.text = object.title
        
        object.overview.isEmpty ? configureMissingDescription() : { overviewTextView.text = object.overview }()
        
        releaseDateLabelValue.text = "\(object.releaseDate)"
        
        popularityLabelValue.text = "\(object.popularity)"
        
        voteCountLabelValue.text = "\(object.voteCount)"
        
        let formattedVoteAverage = ValueFormatting.formatVoteAverage(object.voteAverage)
        voteAverageLabel.text = "\(formattedVoteAverage)/10"
    }
}


// MARK: - DetailsViewModelDelegate

extension DetailsView: DetailsViewModelDelegate {
    
    func updateUI(with model: Media, and genres: [Genre]) {
        configure(with: model, and: genres)
    }
}
