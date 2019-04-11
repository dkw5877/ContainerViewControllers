import UIKit

class Theme {
    
    static var mainColor: UIColor {
        return UIColor(netHex: 0x18afbb)
    }
    
    static var mutedMainColor:UIColor {
        return UIColor(netHex: 0x138c95)
    }
    
    static var backgroundColor:UIColor {
       return UIColor(netHex: 0xF0F0F0)
    }
    
    static var lightBackgroundColor:UIColor {
        return UIColor(netHex: 0xffffff)
    }
    
    static var textColor:UIColor {
        return UIColor(netHex: 0xffffff).withAlphaComponent(0.80)
    }
    
    /* dark grey */
    static var darkTextColor:UIColor {
        return UIColor(netHex: 0xf38434f).withAlphaComponent(0.80)
    }
    
    static var whiteColor:UIColor {
        return .white
    }

    /* orange color from landscape image */
    static var redSky:UIColor {
        return UIColor(netHex: 0xDF5E26)
    }
    
    static var marinaBlue:UIColor {
        return UIColor(red: 55, green: 99, blue: 205)
    }
    
    static var fieldGreen:UIColor {
        return UIColor(red: 46, green: 73, blue: 13)
    }
    
    static var barStyle: UIBarStyle {
        return .default
    }
    
    class func apply() {
        
        // MARK: UINavigationBar
        UINavigationBar.appearance().barStyle = barStyle
        UINavigationBar.appearance().tintColor = whiteColor
        UINavigationBar.appearance().barTintColor = mainColor
        UINavigationBar.appearance().isTranslucent = false

        // MARK: UIBarButtonItem
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let disabledAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes(attributes, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationController.self]).setTitleTextAttributes(disabledAttributes, for: .disabled)
        UINavigationBar.appearance().titleTextAttributes = attributes
    
        // MARK: UITabBar
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = Theme.darkTextColor
        
        // MARK: UISwitch
        UISwitch.appearance().onTintColor = mainColor
        
        // MARK: UISlider
        UISlider.appearance().tintColor = mainColor
        
        // MARK: UIButton
        UIButton.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).tintColor = mainColor
        UIButton.appearance(whenContainedInInstancesOf: [UIScrollView.self]).tintColor = mainColor
        
        // MARK: UITextField
        UITextField.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).tintColor = whiteColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = mainColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = whiteColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
    }

}
