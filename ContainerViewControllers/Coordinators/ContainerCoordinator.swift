
import UIKit

final class ContainerCoordinator: NSObject, Coordinator {
    
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
        initializeContainerContent()
    }
    
    func initializeContainerContent() {
        let imageViewController = getImageViewController()
        let listViewController = getListViewController()
        let profileViewController = ContainerViewController(imageController: imageViewController, listController: listViewController)
        navigationController.pushViewController(profileViewController, animated: false)
    }
    
    private func getImageViewController() ->  UIViewController {
        let urlString = "https://www.stockvault.net/photo/download/180092"
        if let imageLoader = ImageLoader.imageLoader(urlString: urlString) {
            let imageViewController = ImageViewController(imageLoader: imageLoader)
            return imageViewController
        }
        
        return ImageViewController()
    }
    
    private func getListViewController() -> UIViewController {
        let resource = Album.all
        let listLoader = ListLoader(resource: resource)
        let listViewController = ListViewController(listLoader: listLoader)
        listViewController.delegate = self
        return listViewController
    }
}

/* coordinator handles the delegate request to view content detail */
extension ContainerCoordinator : ListViewControllerDelegate {
    func didSelectItem(item: ItemViewModel) {
        navigationController.delegate = self
        let coordinator = ListDetailCoordinator(navigationController: navigationController, item:item)
        coordinator.parent = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}

/* we conform to the UINavigationControllerDelegate to dealloc the coordinator when the back button is pressed
 */
extension ContainerCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController,
                              didShow viewController: UIViewController, animated: Bool) {
        
        // ensure the view controller is popping, here we are pushing another view controller
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(fromViewController) else {
                return
        }
        
        if fromViewController is ListDetailViewController {
            print(fromViewController)
            childDidFinish(child: ListDetailCoordinator.self)
        }
    }
    
    /* remove coordinator from list */
    func childDidFinish<T>(child:T.Type) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator.self is T {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

