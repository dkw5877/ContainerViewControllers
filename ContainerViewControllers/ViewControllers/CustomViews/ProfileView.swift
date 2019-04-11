
import UIKit

class UserProfileView: UIView {

    //public api for view
    public var image:UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    public var name:String? {
        didSet{
            nameLabel.text = name
            nameLabel.sizeToFit()
        }
    }
    
    public var quote:String? {
        didSet{
            quoteLabel.text = quote
            quoteLabel.sizeToFit()
        }
    }
    
    private var imageView:CircularImageView = {
        let imageView = CircularImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var nameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = Fonts.caption
        return label
    }()
    
    private var quoteLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.textColor
        label.numberOfLines = 0
        label.font = Fonts.body
        return label
    }()
    
    private let spacing:CGFloat = 8
    private let imageSize:CGSize = CGSize(width: 200, height: 200)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    private func createSubviews() {
        backgroundColor = Theme.mutedMainColor
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(quoteLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureImageView()
        configureNameLabel()
        configureQuoteLabel()
    }
    
    private func configureImageView(){
        let xOrigin = ceil(frame.midX - imageSize.width/2)
        imageView.frame = CGRect(x: xOrigin, y: spacing, width: imageSize.width, height: imageSize.height)
    }
    
    private func configureNameLabel(){
        let yOrigin = ceil(imageView.frame.maxY + spacing)
        let width = floor(frame.width - layoutMargins.left - layoutMargins.right)
        var height:CGFloat = 0
        if let labelText = nameLabel.text {
            let attributes = [NSAttributedString.Key.font: nameLabel.font!]
            height = calculateTextHeight(width: width, text: labelText, attributes: attributes)
        }
        nameLabel.frame = CGRect(x: layoutMargins.left, y: yOrigin , width: width, height: height)
    }
    
    private func configureQuoteLabel(){
        let yOrigin = ceil(nameLabel.frame.maxY + spacing)
        let width = floor(frame.width - layoutMargins.left - layoutMargins.right)
        var height:CGFloat = 0
        if let labelText = quoteLabel.text {
            let attributes = [NSAttributedString.Key.font: quoteLabel.font!]
            height = calculateTextHeight(width: width, text: labelText, attributes: attributes)
        }
        quoteLabel.frame = CGRect(x: layoutMargins.left, y: yOrigin , width: width, height: height)
    }
        
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.maxY)
    }
}
