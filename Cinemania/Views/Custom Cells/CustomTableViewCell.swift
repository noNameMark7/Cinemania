import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "CustomTableViewCell"
    
    // MARK: - UI Components
    private let posterContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        view.layer.shadowRadius = 3
        view.layer.masksToBounds = false
        view.layer.borderWidth = 0.8
        return view
    }()

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = .placeholder(named: "DefaultPoster")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseBold, ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .label
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseMedium, ofSize: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
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
    
    private let voteAverageLabel: PaddedLabel = {
        let label = PaddedLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.suseMedium, ofSize: 13)
        label.textColor = .label
        label.layer.borderWidth = 0.8
        label.layer.cornerRadius = 4
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let titleLabelBottom = titleLabel.frame.maxY
        let voteAverageLabelTop = voteAverageLabel.frame.minY
        
        let centerY = (titleLabelBottom + voteAverageLabelTop) / 2
        
        genreLabel.frame.origin.y = centerY - (genreLabel.frame.height / 2)
    }
    
    // MARK: - Theme appearance
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateAppearance(for: traitCollection)
    }
}


// MARK: - Initial Setup
extension CustomTableViewCell {
    
    func initialSetup() {
        configureUI()
    }
    
    func configureUI() {
        contentView.addSubview(posterContainerView)
        posterContainerView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(tmdbImageView)
        contentView.addSubview(voteAverageLabel)
        
        let posterContainerViewConstraints = [
            posterContainerView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            posterContainerView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            posterContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterContainerView.widthAnchor.constraint(equalToConstant: 120),
            posterContainerView.heightAnchor.constraint(equalToConstant: 180)
        ]
        
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: posterContainerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: posterContainerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: posterContainerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: posterContainerView.bottomAnchor)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8)
        ]
        
        let genreLabelConstraints = [
            genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            genreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -22),
        ]
        
        let tmdbImageViewConstraints = [
            tmdbImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
            tmdbImageView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            tmdbImageView.widthAnchor.constraint(equalToConstant: 42),
            tmdbImageView.heightAnchor.constraint(equalToConstant: 22)
        ]
        
        let voteAverageLabelConstraints = [
            voteAverageLabel.leadingAnchor.constraint(equalTo: tmdbImageView.trailingAnchor, constant: 8),
            voteAverageLabel.centerYAnchor.constraint(equalTo: tmdbImageView.centerYAnchor),
            voteAverageLabel.heightAnchor.constraint(equalTo: tmdbImageView.heightAnchor)
        ]
        
        NSLayoutConstraint.activate(posterContainerViewConstraints)
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
        NSLayoutConstraint.activate(tmdbImageViewConstraints)
        NSLayoutConstraint.activate(voteAverageLabelConstraints)
        
        updateAppearance(for: traitCollection)
    }
    
    func updateAppearance(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            posterContainerView.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).cgColor
            voteAverageLabel.layer.borderColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1).cgColor
        } else {
            posterContainerView.layer.borderColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            voteAverageLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        }
    }
}


// MARK: - Cell Configuration
extension CustomTableViewCell {
    
    func configureWith(_ object: Media, and genre: [Genre]) {
        if let posterURL = URL(string: GET_IMAGE + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        titleLabel.text = object.title
        
        genreLabel.text = object.genre.compactMap({ genreID in
            genre.first { $0.id == genreID }?.name
        }).joined(separator: "・")
        
        let formattedVoteAverage = FormattingReleaseDateValue.formattingToFloat(object.voteAverage)
        voteAverageLabel.text = "\(formattedVoteAverage)/10"
    }
    
    func configureWith(_ object: MediaRealm, and genre: [Genre]) {
        if let posterURL = URL(string: GET_IMAGE + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        titleLabel.text = object.title
        
        genreLabel.text = object.genre.compactMap({ genreID in
            genre.first { $0.id == genreID }?.name
        }).joined(separator: "・")
        
        let formattedVoteAverage = FormattingReleaseDateValue.formattingToFloat(object.voteAverage)
        voteAverageLabel.text = "\(formattedVoteAverage)/10"
    }
    
    func configureWith(_ media: Movies, and genre: [Genre]) {
        let posterUrl = URL(string: "\(GET_IMAGE)\(media.posterPath)")
        posterImageView.sd_setImage(with: posterUrl)
        
        titleLabel.text = media.title
        
        let formattedVoteAverage = FormattingReleaseDateValue.formattingToFloat(media.voteAverage)
        voteAverageLabel.text = "\(formattedVoteAverage)/10"
        
        genreLabel.text = Media(from: media).genre.compactMap({ genreID in
            genre.first { $0.id == genreID }?.name
        }).joined(separator: "・")
    }
}
