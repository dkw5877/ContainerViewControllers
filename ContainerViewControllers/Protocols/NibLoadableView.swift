import UIKit

protocol NibLoadableView: class {}

/* use the name of the nib class as the nib name */
extension NibLoadableView where Self: UIView {

    static var nibName:String {
        return String(describing: self)
    }
}
