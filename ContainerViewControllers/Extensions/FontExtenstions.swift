

import UIKit.UIFont

extension UIFont {

    func sizeOfString(string: String, constrainedToWidth width: CGFloat) -> CGSize {
        let size = string.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude),options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: self], context: nil).size
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    func sizeOfStringCTFrame(string: String, constrainedToWidth width: CGFloat) -> CGSize {
        let attributes = [NSAttributedString.Key.font:self,]
        let attString = NSAttributedString(string: string,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: .greatestFiniteMagnitude), nil)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
}
