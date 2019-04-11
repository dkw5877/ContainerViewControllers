
import UIKit

class StoryView: UIView {

    //public api for view
    public var image:UIImage? {
        didSet{
            imageView.image = image
        }
    }
    
    public var text:String? {
        didSet{
            textLabel.text = text
            textLabel.sizeToFit()
        }
    }
    
    public var content: String? {
        didSet {
            textView.text = content
            textLabel.sizeToFit()
        }
    }
    
    public var labelColor:UIColor? {
        didSet {
            textLabel.backgroundColor = labelColor
        }
    }
    
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var textLabel:UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Theme.textColor
        label.textAlignment = .center
        label.font = Fonts.caption
        return label
    }()
    
    private var textView:UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = Theme.darkTextColor
        textView.font = Fonts.body
        textView.isEditable = false
        return textView
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
        addSubview(imageView)
        addSubview(textLabel)
        addSubview(textView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutImageView()
        layoutTextLabel()
        layoutTextView()
    }
    
    func layoutImageView() {
        let size = frame.size
        imageView.frame = CGRect(x: 0, y:0, width: size.width, height: ceil(size.height * 0.40))
    }
    
    func layoutTextLabel() {
        let imageFrame = imageView.frame
        let width = imageView.frame.size.width
        var height:CGFloat = 0
        
        if let labelText = textLabel.text {
            let attributes = [NSAttributedString.Key.font: textLabel.font!]
            height = calculateTextHeight(width: width, text: labelText, attributes: attributes)
        }

        textLabel.frame = CGRect(x: imageFrame.origin.x, y: imageFrame.maxY, width: width, height: height)
    }
    
    func layoutTextView() {
        let yOrigin = textLabel.frame.maxY
        let width = textLabel.frame.size.width
        let height:CGFloat = ceil(frame.height - textLabel.frame.maxY)
        textView.frame = CGRect(x: imageView.frame.origin.x, y: yOrigin, width: width, height:height)
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: frame.width, height: frame.maxY)
    }
}
