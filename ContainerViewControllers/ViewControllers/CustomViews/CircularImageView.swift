
import Foundation
import UIKit.UIView

class CircularImageView : UIImageView {
    
    let maskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    //create circular mask to round image view
    private func configure () {
        maskLayer.bounds = bounds
        maskLayer.frame = bounds
        let path = UIBezierPath(ovalIn: bounds)
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
