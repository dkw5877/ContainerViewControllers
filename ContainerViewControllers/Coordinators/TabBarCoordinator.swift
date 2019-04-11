
import UIKit

final class TabBarCoordinator: Coordinator {

    var tabBarController:UITabBarController
    var childCoordinators = [Coordinator]()
    weak var parent:Coordinator?
    
    private let containerNavigationController:UINavigationController
    private let scrollContentNavigationController:UINavigationController
    private let stackViewContentNavigationController:UINavigationController
    private let cardContainerNavigationController:UINavigationController
    
    init(tabBarController:UITabBarController) {
        self.tabBarController = tabBarController
        self.containerNavigationController = UINavigationController()
        self.scrollContentNavigationController = UINavigationController()
        self.stackViewContentNavigationController = UINavigationController()
        self.cardContainerNavigationController = UINavigationController()
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func start() {
        let containerCoordinator = ContainerCoordinator(navigationController: containerNavigationController)
        containerCoordinator.parent = self
        childCoordinators.append(containerCoordinator)
        containerCoordinator.start()
        
        let verticalScrollingCoordinator = VerticalScrollingCoordinator(navigationController: scrollContentNavigationController)
        verticalScrollingCoordinator.parent = self
        childCoordinators.append(verticalScrollingCoordinator)
        verticalScrollingCoordinator.start()
        
        let stackViewCoordinator = StackViewCoordinator(navigationController: stackViewContentNavigationController)
        stackViewCoordinator.parent = self
        childCoordinators.append(stackViewCoordinator)
        stackViewCoordinator.start()
        
        let cardContainerCoordinator = CardContainerCoordinator(navigationController: cardContainerNavigationController)
        cardContainerCoordinator.parent = self
        childCoordinators.append(cardContainerCoordinator)
        cardContainerCoordinator.start()
        
        tabBarController.setViewControllers([containerNavigationController, scrollContentNavigationController, stackViewContentNavigationController, cardContainerNavigationController], animated: true)
        (tabBarController as? TabBarController)?.setTitles(titles: ["Container", "Scrollable", "StackView", "Card Containter"])
        tabBarController.selectedIndex = 0;
    }

}
