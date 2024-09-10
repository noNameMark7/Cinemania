import UIKit

// MARK: - Image extension

extension UIImage {
    
    static func placeholder(named: String) -> UIImage? {
        UIImage(named: named) ?? UIImage(systemName: "photo")
    }
}
