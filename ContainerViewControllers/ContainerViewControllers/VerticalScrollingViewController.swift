import UIKit

final class VerticalScrollingViewController: UIViewController {

    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame:UIScreen.main.bounds)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.backgroundColor = Theme.backgroundColor
        return scrollView
    }()
    
    private var scrollViewContent = [UIViewController]()
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    init(contents:[UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.scrollViewContent.append(contentsOf: contents)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func loadView() {
        view = scrollView
        add(contents: scrollViewContent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Scrollable"
    }
    
    func add(contents:[UIViewController]){
        for child in contents {
            add(child: child, in:scrollView)
            portrait(content: child)
        }
    }
    
    private func portrait(content:UIViewController) {
        let bounds = view.bounds
        var contentSize = content.view.frame.size
        
        if content.preferredContentSize != .zero {
            contentSize = content.preferredContentSize
        }
        
        let y:CGFloat = scrollView.contentSize.height
        let size = CGSize(width:bounds.width, height:contentSize.height)
        let height = scrollView.contentSize.height + contentSize.height
        let origin = CGPoint(x: 0, y: y)
        content.view.frame = CGRect(origin: origin, size: size)
        
        scrollView.contentSize = CGSize(width: bounds.width, height: height)
    }
  
    private func landscape(content:UIViewController){
        let bounds = UIScreen.main.bounds
        var contentSize = content.view.frame.size
        
        if content.preferredContentSize != .zero {
            contentSize = content.preferredContentSize
        }
        
        let x:CGFloat = scrollView.contentSize.width
        let size = CGSize(width:scrollView.contentSize.width, height:contentSize.height)
        let scrollWidth = scrollView.contentSize.width
        
        let origin = CGPoint(x: x, y: 0)
        content.view.frame = CGRect(origin: origin, size: size)
        scrollView.contentSize = CGSize(width: scrollWidth, height: bounds.height)
    }
    
    /* Notifies an interested controller that the preferred content size of one of its children changed. */
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        print(#function)
    }
    
    /* Notifies the container that a child view controller was resized using auto layout. */
    override func systemLayoutFittingSizeDidChange(forChildContentContainer container: UIContentContainer) {
        print(#function)
    }
    
}
