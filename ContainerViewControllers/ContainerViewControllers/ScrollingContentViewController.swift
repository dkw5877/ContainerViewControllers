
import UIKit

/**
 * ScrollingContentViewController
 * See Dave DeLongs example at https://github.com/davedelong/MVCTodo
 */
final class ScrollingContentViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let scrollViewContentContainer = UIView()
    private let content: UIViewController
        
    init(content: UIViewController) {
        self.content = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = UIView()
        scrollView.preservesSuperviewLayoutMargins = true
        scrollView.backgroundColor = Theme.mainColor
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
            ])

         /* add child controller and setup constraints */
        add(child: content, in: scrollView)
        content.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            content.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            content.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            content.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            content.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            content.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = content.title
    }
 
}
