import UIKit

final class StackViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    weak var parent:Coordinator?
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController) {
        childCoordinators = [Coordinator]()
        self.navigationController = navigationController
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func start() {
        initialzieStackViewContent()
    }
    
    private func initialzieStackViewContent(){
        let storyViewController1 = StoryViewController(viewModel: MarinaStory())
        storyViewController1.labelColor = Theme.marinaBlue
        let storyViewController2 = StoryViewController(viewModel: TajMahalStory())
        storyViewController2.labelColor = Theme.fieldGreen
        let stack = StackViewController(content: [storyViewController1, storyViewController2])
        let stackContainer = ScrollingContentViewController(content: stack)
        navigationController.pushViewController(stackContainer, animated: false)
    }
}



