import UIKit

final class ImageViewController: UIViewController {
    
    private var imageLoader:ImageLoader? = nil
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    convenience init(imageLoader:ImageLoader) {
        self.init()
        self.imageLoader = imageLoader
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        layoutImageView()
        let loadingController = LoadingViewController()
        add(child: loadingController)
        loadImage()
    }
    
    private func layoutImageView(){
        imageView.frame = view.frame
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutImageView()
    }
    
    private func loadImage() {
        imageLoader?.loadImage { [weak self] (image) in
            DispatchQueue.main.async {
                self?.imageView.image = image
                let _ = self?.children
                    .filter { $0 is LoadingViewController }
                    .map{ self?.remove(child: $0) }
            }
        }
    }
}

