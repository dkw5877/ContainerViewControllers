
import UIKit.UIView

class HandleView : UIView {
    
    private let lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
    }
    
    private func addSubviews(){
        lineView.backgroundColor = Theme.whiteColor
        addSubview(lineView)
        configureSubviews()
    }
    
    private func configureSubviews() {
        let lineFrame = CGRect(x: 0, y: 0, width: frame.width * 0.25, height: frame.height * 0.25)
        lineView.layer.cornerRadius = frame.height * 0.20
        lineView.frame = lineFrame
        lineView.center = self.center
    }
}
