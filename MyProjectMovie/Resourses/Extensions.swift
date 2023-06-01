import Foundation
import UIKit

extension String {
    
    func capitilizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

extension UIScrollView {
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

extension UIImageView {
    func gradient(imageView: UIImageView) {
        let imageHeight = imageView.image?.size.height ?? 300
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0, 1]
        gradient.frame = CGRect(x: 0, y: imageHeight * 0.8, width: imageView.bounds.width, height: imageHeight * 0.2)
        imageView.layer.addSublayer(gradient)
    }
}

extension UITableViewHeaderFooterView {
    func setupHeader(header: UITableViewHeaderFooterView) {
        header.textLabel?.font = UIFont(name: Font.helveticaBold.rawValue, size: 18)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.contentView.backgroundColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitilizeFirstLetter()
    }
}
