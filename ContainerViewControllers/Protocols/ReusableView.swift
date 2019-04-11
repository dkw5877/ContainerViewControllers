import UIKit

protocol ReusableView: class {}

/* use the name of the cell class as the reuse identifier */
extension ReusableView where Self: UIView {
    static var reuseIdentifier:String { return String(describing: self) }
}
