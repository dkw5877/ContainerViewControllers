
import UIKit

final class ContainerViewController: UIViewController {

    private let imageController:UIViewController
    private let listController:UIViewController
    
    init(imageController:UIViewController, listController:UIViewController) {
        self.imageController = imageController
        self.listController = listController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Container"
        view.backgroundColor = Theme.backgroundColor
        add(child: imageController, in: view)
        add(child: listController, in: view)
        layoutViewControllers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutViewControllers()
    }
    
    private func layoutViewControllers() {
        let frame = view.frame
        imageController.view.frame = .init(x: 0, y: 0, width: frame.width, height: frame.height * 0.40)
        let yOrigin = ceil(imageController.view.frame.height/2)
        let height = ceil(frame.maxY - imageController.view.frame.maxY)
        listController.view.frame = .init(x: 0, y: yOrigin, width: frame.width, height: height)
    }
}
