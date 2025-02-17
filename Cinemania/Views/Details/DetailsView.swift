import UIKit
import SDWebImage
import YouTubeiOSPlayerHelper
import RealmSwift

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
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    private let posterContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowRadius = 5
        view.layer.masksToBounds = false
        view.layer.borderWidth = 0.8
        view.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        return view
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultPoster")
        return imageView
    }()
    
    private let titleValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseBold, ofSize: 19)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    // MARK: - Contains all properties below
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let genreLabelValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseMedium, ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About"
        label.font = .customFont(.suseBold, ofSize: 20)
        return label
    }()
    
    let overviewValueTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .label
        textView.font = .customFont(.suseRegular, ofSize: 15)
        textView.textContainer.lineBreakMode = .byWordWrapping
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 10
        textView.layer.masksToBounds = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return textView
    }()
    
    private let firstSeparatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        return view
    }()
    
    private let trailerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trailer"
        label.font = .customFont(.suseBold, ofSize: 20)
        label.textColor = .label
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
        view.heightAnchor.constraint(equalToConstant: 0.7).isActive = true
        return view
    }()
    
    private let informationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Information"
        label.font = .customFont(.suseBold, ofSize: 20)
        label.textColor = .label
        return label
    }()
    
    
    private let popularityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Popularity"
        label.font = .customFont(.suseRegular, ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let popularityValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let votedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Voted"
        label.font = .customFont(.suseRegular, ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let voteCountValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let voteAverageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Vote average"
        label.font = .customFont(.suseRegular, ofSize: 14)
        label.textColor = .label
        return label
    }()
    
    private let voteAverageValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseRegular, ofSize: 12)
        label.textColor = .secondaryLabel
        return label
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance(for: traitCollection)
    }
}

// MARK: - Setup UI
extension DetailsView {
    
    func setupUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backdropImageView)
        backdropImageView.addSubview(backdropOverlayView)
        contentView.addSubview(posterContainerView)
        posterContainerView.addSubview(posterImageView)
        contentView.addSubview(titleValueLabel)
        contentView.addSubview(containerView)
        
        containerView.addSubview(genreLabelValue)
        containerView.addSubview(aboutLabel)
        containerView.addSubview(overviewValueTextView)
        containerView.addSubview(firstSeparatorView)
        containerView.addSubview(trailerLabel)
        containerView.addSubview(playerView)
        containerView.addSubview(informationLabel)
        containerView.addSubview(secondSeparatorView)
        containerView.addSubview(popularityLabel)
        containerView.addSubview(popularityValueLabel)
        containerView.addSubview(votedLabel)
        containerView.addSubview(voteCountValueLabel)
        containerView.addSubview(voteAverageLabel)
        containerView.addSubview(voteAverageValueLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
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
        
        let posterContainerViewConstraints = [
            posterContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 176),
            posterContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterContainerView.heightAnchor.constraint(equalToConstant: 140),
            posterContainerView.widthAnchor.constraint(equalToConstant: 93)
        ]
        
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: posterContainerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: posterContainerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: posterContainerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: posterContainerView.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            titleValueLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleValueLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 20),
            titleValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            titleValueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 16),
        ]
        
        let containerViewConstraints = [
            containerView.topAnchor.constraint(equalTo: titleValueLabel.bottomAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 34),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ]
        
        let genreLabelValueConstraints = [
            genreLabelValue.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            genreLabelValue.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            genreLabelValue.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
            genreLabelValue.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor, constant: 16),
        ]
        
        let aboutLabelConstraints = [
            aboutLabel.topAnchor.constraint(equalTo: genreLabelValue.bottomAnchor, constant: 22),
            aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let overviewTextViewConstraints = [
            overviewValueTextView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 12),
            overviewValueTextView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            overviewValueTextView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let firstSeparatorViewConstraints = [
            firstSeparatorView.topAnchor.constraint(equalTo: overviewValueTextView.bottomAnchor, constant: 32),
            firstSeparatorView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            firstSeparatorView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let trailerLabelConstraints = [
            trailerLabel.topAnchor.constraint(equalTo: firstSeparatorView.bottomAnchor, constant: 24),
            trailerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let playerViewConstraints = [
            playerView.topAnchor.constraint(equalTo: trailerLabel.bottomAnchor, constant: 16),
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
            popularityLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 16),
            popularityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let popularityLabelValueConstraints = [
            popularityValueLabel.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: 4),
            popularityValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let votedLabelConstraints = [
            votedLabel.topAnchor.constraint(equalTo: popularityValueLabel.bottomAnchor, constant: 16),
            votedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]

        let voteCountLabelValueConstraints = [
            voteCountValueLabel.topAnchor.constraint(equalTo: votedLabel.bottomAnchor, constant: 4),
            voteCountValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let voteAverageLabelConstraints = [
            voteAverageLabel.topAnchor.constraint(equalTo: voteCountValueLabel.bottomAnchor, constant: 16),
            voteAverageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ]
        
        let voteAverageValueLabelConstraints = [
            voteAverageValueLabel.topAnchor.constraint(equalTo: voteAverageLabel.bottomAnchor, constant: 4),
            voteAverageValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            voteAverageValueLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -32)
        ]

        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(backdropImageViewConstraints)
        NSLayoutConstraint.activate(backdropOverlayViewConstraints)
        NSLayoutConstraint.activate(posterContainerViewConstraints)
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(containerViewConstraints)
        NSLayoutConstraint.activate(genreLabelValueConstraints)
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
        NSLayoutConstraint.activate(voteAverageLabelConstraints)
        NSLayoutConstraint.activate(voteAverageValueLabelConstraints)

        scrollView.contentSize = contentView.bounds.size
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            posterContainerView.layer.shadowColor = UIColor.gray.cgColor
            contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            containerView.backgroundColor = #colorLiteral(red: 0.217025317, green: 0.2191740825, blue: 0.2191740825, alpha: 1)
            overviewValueTextView.backgroundColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
            firstSeparatorView.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1).withAlphaComponent(0.18)
            secondSeparatorView.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1).withAlphaComponent(0.18)
        } else {
            posterContainerView.layer.shadowColor = UIColor.black.cgColor
            contentView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            containerView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9647058824, alpha: 1)
            overviewValueTextView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            firstSeparatorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.18)
            secondSeparatorView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.18)
        }
    }
}

// MARK: - Text processing in UITextView
private extension DetailsView {
    
    // MARK: - Add link into overviewTextView and show message if overview is missing
    func configureMissingDescription() {
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
        
        attributedText.addAttribute(
            .foregroundColor,
            value: textColor,
            range: NSMakeRange(0, attributedText.length)
        )
        
        overviewValueTextView.attributedText = attributedText
        overviewValueTextView.isUserInteractionEnabled = true
        overviewValueTextView.isSelectable = true
        overviewValueTextView.isEditable = false
    }
    
    // MARK: - Show message if trailer is missing
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
    
    private func extractVideoId(from trailerUrl: URL) -> String? {
        guard let queryItems = URLComponents(
            url: trailerUrl,
            resolvingAgainstBaseURL: true
        )?.queryItems else {
            return nil
        }

        guard let vQueryItem = queryItems.first(where: { $0.name == "v" }), let videoId = vQueryItem.value else {
            return nil
        }
        return videoId
    }
    
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
        if let backdropURL = URL(string: GET_IMAGE + object.backdrop) {
            backdropImageView.sd_setImage(with: backdropURL, placeholderImage: .placeholder(named: "DefaultBackdrop"))
        } else {
            backdropImageView.image = .placeholder(named: "DefaultBackdrop")
        }
        
        if let posterURL = URL(string: GET_IMAGE + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        genreLabelValue.text = object.genre.compactMap({ genreID in
            genres.first { $0.id == genreID }?.name
        }).joined(separator: "・")
        
        titleValueLabel.text = object.title + " (\(object.releaseDate))"
        
        object.overview.isEmpty ? configureMissingDescription() : { overviewValueTextView.text = object.overview }()
        
        popularityValueLabel.text = "\(object.popularity)"
        
        voteCountValueLabel.text = "\(object.voteCount)"
        
        let formattedVoteAverage = FormattingReleaseDateValue.formattingToIntegerWithPercentage(object.voteAverage)
        voteAverageValueLabel.text = formattedVoteAverage
    }
}

// MARK: - DetailsViewModelDelegate
extension DetailsView: DetailsViewModelDelegate {
    
    func updateUI(with model: Media, and genres: [Genre]) {
        configure(with: model, and: genres)
    }
}
