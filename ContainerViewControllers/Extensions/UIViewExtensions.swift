import UIKit

extension UIView {
    
    /**
     * Extensions for ScrollingContentViewController
     * See Dave DeLongs example at https://github.com/davedelong/MVCTodo
     */
    func embedSubview(_ subview: UIView) {
        // do nothing if this view is already in the right place
        if subview.superview == self { return }
        
        if subview.superview != nil {
            subview.removeFromSuperview()
        }
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.frame = bounds
        addSubview(subview)
        
        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: subview.trailingAnchor),
            
            subview.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor)
            ])
    }
    
    /**
     * Extensions for ScrollingContentViewController
     * See Dave DeLongs example at https://github.com/davedelong/MVCTodo
     */
    func isContainedWithin(_ other: UIView) -> Bool {
        var current: UIView? = self
        while let proposedView = current {
            if proposedView == other { return true }
            current = proposedView.superview
        }
        return false
    }
    
    func calculateTextHeight(width:CGFloat, text:String, attributes:[NSAttributedString.Key:UIFont]) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelRect = text.boundingRect(with: size, options:[.usesLineFragmentOrigin, .usesFontLeading], attributes:attributes, context: nil)
        let height = ceil(labelRect.height)
        return height
    }
    
}

