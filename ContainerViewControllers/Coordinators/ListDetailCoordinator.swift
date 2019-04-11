
import UIKit

final class ListDetailCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parent:Coordinator?
    private var item:ItemViewModel
   
    init(navigationController:UINavigationController, item:ItemViewModel){
        self.navigationController = navigationController
        self.item = item
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    func start() {
      showDetailView()
    }
    
    private func showDetailView(){
        let imageLoader = ImageLoader.imageLoader(urlString: item.url)
        let listDetailViewController = ListDetailViewController(imageLoader:imageLoader, item: item)
        navigationController.pushViewController(listDetailViewController, animated: true)
    }
}
