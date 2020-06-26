import UIKit
import Kingfisher

class AvatarImageView: UIView {
    
    // ImageView Attributes
    fileprivate var imageView = UIImageView()
    var image: UIImage? {
        get { imageView.image }
        set { imageView.image = newValue }
    }
    
    var url: String? {
        didSet {
            if let urlStr = url {
                imageView.kf.setImage(with: URL(string: urlStr ))
            }
        }
    }
    
    var height: CGFloat = 0 {
        didSet {
            guard height > 0 else { return }
            NSLayoutConstraint .activate([
                widthAnchor.constraint(equalToConstant: height),
                heightAnchor.constraint(equalToConstant: height)
            ])
            cornerRadius = height / 2
        }
    }
    
    // Shadow Attributes
    var shadowColor: UIColor = .black
    var shadowOpacity: Float = 0.0
    var shadowRadius: CGFloat = 0.0
    var shadowOffset: CGSize = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        layoutImage()
        dropShadow()
    }
    
    fileprivate func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        self.backgroundColor = .systemBackground
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        addGestureRecognizer(tap)
    }
    
    fileprivate func layoutImage() {
        self.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = self.contentMode
        imageView.layer.cornerRadius = self.layer.cornerRadius
        imageView.layer.masksToBounds = true
    }
    
    fileprivate func dropShadow() {
        if traitCollection.userInterfaceStyle == .dark {
            self.layer.shadowColor = UIColor.lightGray.cgColor
        } else {
            self.layer.shadowColor = shadowColor.cgColor
        }
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: cornerRadius).cgPath
    }
    
    @objc func tapAction() {
        let coeff = 0.75
        UIView .animate(withDuration: coeff,
                        animations: { [weak self] in
                            self?.transform = CGAffineTransform.identity.scaledBy(x: CGFloat(coeff), y: CGFloat(coeff))
                            
            },
                        completion: { [weak self] (finish) in
                            UIView .animate(withDuration: coeff, animations: {
                                self?.transform = CGAffineTransform.identity
                            })
        })
        
    }
    
}
