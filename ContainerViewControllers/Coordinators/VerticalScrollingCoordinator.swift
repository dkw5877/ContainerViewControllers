
import UIKit

final class VerticalScrollingCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    weak var parent:Coordinator?
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController) {
        childCoordinators = [Coordinator]()
        self.navigationController = navigationController
    }
    
    func start() {
        initialzieVerticalScrollContent()
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    private func initialzieVerticalScrollContent(){
        let profileViewController = UserProfileViewController(viewModel: Profile())
        let storyViewController = StoryViewController(viewModel: Story())
        storyViewController.labelColor = Theme.redSky
        let scrollingViewController = VerticalScrollingViewController(contents: [profileViewController, storyViewController])
        navigationController.pushViewController(scrollingViewController, animated: false)
    }
}
