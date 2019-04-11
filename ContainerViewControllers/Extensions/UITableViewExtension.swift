import UIKit

extension UITableView {

    /* create extension to load class and assign reuse identifier */
    func register<T:UITableViewCell>(_:T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /* create extension to load nib and assign reuse identifier */
//    func register<T:UITableViewCell>(_:T.Type) where T:NibLoadableView  {
//        let nib = UINib(nibName: T.nibName, bundle: nil)
//        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
//    }

    /* create extension to dequque and load reusable cell */
    func dequeueReusableCell<T:UITableViewCell>(forIndexPath indexPath:IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier:\(T.reuseIdentifier)")
        }
        return cell
    }

}




































