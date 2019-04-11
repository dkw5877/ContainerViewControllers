import UIKit

final class CardContainerCoordinator: Coordinator {
    
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
        initialzieCardViewContent()
    }
    
    private func initialzieCardViewContent(){
        let imageViewController = getImageViewController()
        let cardViewController = CardViewController()
        let cardContainter = CardContainerViewController(mainViewController: imageViewController, cardViewController: cardViewController)
        navigationController.pushViewController(cardContainter, animated: false)
    }
    
    private func getImageViewController() ->  UIViewController {
        let url = Bundle.main.url(forResource: "dmitriy-ilkevich", withExtension: "png")!
        let resource = Resource<UIImage>(url: url, parse: { (data) -> UIImage? in
            let image = UIImage(data: data)
            return image
        })
        
        let imageLoader = ImageLoader(resource: resource)
        let imageViewController = ImageViewController(imageLoader: imageLoader)
        return imageViewController
    }
}




