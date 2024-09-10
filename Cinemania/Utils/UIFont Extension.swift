import UIKit

// MARK: - Fonts extension

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
