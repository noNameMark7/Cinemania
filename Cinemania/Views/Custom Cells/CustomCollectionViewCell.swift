import UIKit
import SDWebImage

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CustomCollectionViewCell"
    
    // MARK: - Properties
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
}


// MARK: - Cell Configuration
extension CustomCollectionViewCell {
    
    func configure(with media: Media) {
        let posterUrl = URL(string: "\(GET_IMAGE)\(media.poster)")
        posterImageView.sd_setImage(with: posterUrl)
    }
}
