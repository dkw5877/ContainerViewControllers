import UIKit

final class ListDetailViewController: UIViewController {

    let loadingController = LoadingViewController()
    private var contentView = ContentView()
    private let item:ItemViewModel
    private let imageLoader:ImageLoader?
    
    init(imageLoader:ImageLoader?, item:ItemViewModel) {
        self.item = item
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    override func loadView() {
        contentView.bounds = UIScreen.main.bounds
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingController.color = .white
        add(child: loadingController)
        contentView.content = item.title
        imageLoader?.loadImage { [unowned self] (image) in
            DispatchQueue.main.async {
                self.contentView.image = image
                self.remove(child: self.loadingController)
            }
        }
    }
    
}
