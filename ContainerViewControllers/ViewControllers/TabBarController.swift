import UIKit

final class TabBarController: UITabBarController {
        
    public func setIconImages(titles:[String]) {
        guard let items = self.tabBar.items else { return }
        
        for (index, element) in items.enumerated() {
            let image = UIImage(named:titles[index])
            element.image = image
        }
    }
    
    public func setTitles(titles:[String]) {
        guard let items = self.tabBar.items else { return }
        
        for (index, element) in items.enumerated() {
            element.title = titles[index]
        }
    }
}
