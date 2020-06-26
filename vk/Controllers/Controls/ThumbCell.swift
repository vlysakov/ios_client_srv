import UIKit
import Kingfisher

class ThumbCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ThumbCell"
    var imageView: UIImageView = UIImageView(frame: .zero)
    
    var urlString: String? {
        didSet {
            if let urlStr = urlString {
                imageView.kf.setImage(with: URL(string: urlStr ))
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                })
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
}
