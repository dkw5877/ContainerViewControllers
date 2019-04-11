
import UIKit

class ContentView: UIView {

    //public api for class
    public var image:UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    public var content:String? {
        didSet{
            contentLabel.text = content
            contentLabel.sizeToFit()
        }
    }
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var contentLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = Theme.lightBackgroundColor
        label.textColor = Theme.darkTextColor
        label.numberOfLines = 0
        label.font = Fonts.caption
        return label
    }()
    
    private var contentHolder:UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    private func createSubviews() {
        backgroundColor = Theme.lightBackgroundColor
        addSubview(imageView)
        addSubview(contentHolder)
        contentHolder.addSubview(contentLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureImageView()
        configureLabel()
    }
    
    private func configureImageView(){
        imageView.frame = .init(x: 0, y: 0, width:frame.width , height: ceil(frame.height * 0.50))
    }
    
    private func configureLabel(){
        var origin = imageView.frame.origin
        origin.y += imageView.frame.height
        let height = ceil(frame.height - imageView.frame.height - safeAreaInsets.bottom)
        let size = CGSize(width: imageView.frame.width, height: height)
        contentHolder.frame = .init(origin: origin, size: size)
        contentLabel.frame = contentHolder.bounds.insetBy(dx: 20, dy: 20)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.maxY)
    }
}
