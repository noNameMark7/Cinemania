import UIKit

extension UIImage {
    static func placeholder(named: String) -> UIImage? {
        UIImage(named: named) ?? UIImage(systemName: "photo")
    }
}
