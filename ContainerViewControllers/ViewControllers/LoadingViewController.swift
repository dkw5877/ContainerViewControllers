import UIKit

final class LoadingViewController: UIViewController {

    public var color:UIColor? {
        didSet {
            activityIndicator.color = color
        }
    }
    
    private var activityIndicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = Theme.mainColor
        return indicator
    }()
    
    deinit {
        print("deallocing \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = view.center
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }

}
