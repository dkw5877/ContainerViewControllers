
import UIKit.UIImage

extension UIImage {
    
    convenience init(bundleName: String) {
        self.init(named: bundleName)!
    }
    
}
