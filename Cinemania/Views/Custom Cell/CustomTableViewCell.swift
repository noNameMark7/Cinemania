import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CustomTableViewCell"
    
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
        label.numberOfLines = 0
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .customFont(.manropeRegular, ofSize: 12)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
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
        return label
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(tmdbImageView)
        contentView.addSubview(voteAverageLabel)
        
        settingUIElementsAndConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func settingUIElementsAndConstraints() {
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            posterImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 124),
            posterImageView.heightAnchor.constraint(equalToConstant: 180)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -16)
        ]
        
        let genreLabelConstraints = [
            genreLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            genreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 41),
            genreLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -16)
        ]
        
        let tmdbImageViewConstraints = [
            tmdbImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            tmdbImageView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            tmdbImageView.widthAnchor.constraint(equalToConstant: 42),
            tmdbImageView.heightAnchor.constraint(equalToConstant: 21.8)
        ]
        
        let voteAverageLabelConstraints = [
            voteAverageLabel.leadingAnchor.constraint(equalTo: tmdbImageView.trailingAnchor, constant: 8),
            voteAverageLabel.bottomAnchor.constraint(equalTo: tmdbImageView.bottomAnchor, constant: -1.8)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(genreLabelConstraints)
        NSLayoutConstraint.activate(tmdbImageViewConstraints)
        NSLayoutConstraint.activate(voteAverageLabelConstraints)
    }
    
    func configure(with object: Media, and genre: [Genre]) {
        if let posterURL = URL(string: Constants.getImage + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        titleLabel.text = object.title
        
        genreLabel.text = object.genre.compactMap({ genreID in
            genre.first { $0.id == genreID }?.name
        }).joined(separator: ", ")
        
        let formattedVoteAverage = ValueFormatting.formatVoteAverage(object.voteAverage)
        voteAverageLabel.text = formattedVoteAverage
    }
    
    func configure(with object: MediaRealm, and genre: [Genre]) {
        if let posterURL = URL(string: Constants.getImage + object.poster) {
            posterImageView.sd_setImage(with: posterURL, placeholderImage: .placeholder(named: "DefaultPoster"))
        } else {
            posterImageView.image = .placeholder(named: "DefaultPoster")
        }
        
        titleLabel.text = object.title
        
        genreLabel.text = object.genre.compactMap({ genreID in
            genre.first { $0.id == genreID }?.name
        }).joined(separator: ", ")
        
        let formattedVoteAverage = ValueFormatting.formatVoteAverage(object.voteAverage)
        voteAverageLabel.text = formattedVoteAverage
    }
}
