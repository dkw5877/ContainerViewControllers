import UIKit

protocol TabbedCoordinator {
    var childCoordinators: [Coordinator] { get set }
    var tabBarController: UITabBarController { get set }
    func start()
}
