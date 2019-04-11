import UIKit

final class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators = [Coordinator]()
    private let tabBarController:UITabBarController
    
    init(tabBarController:UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func start() {
        showTabBarView()
    }
    
    private func showTabBarView() {
        let tabBarCoordinatorCoordinator = TabBarCoordinator(tabBarController: tabBarController)
        tabBarCoordinatorCoordinator.parent = self
        childCoordinators.append(tabBarCoordinatorCoordinator)
        tabBarCoordinatorCoordinator.start()
    }
}

extension AppCoordinator : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            navigationController.viewControllers.contains(fromViewController) else { return }
    }
}
