
import UIKit

final class StackViewController: UIViewController {

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private var contents:[UIViewController]
    private var portraitConstraints = [NSLayoutConstraint]()
    private var landscapeConstraints = [NSLayoutConstraint]()

    init(content:[UIViewController]) {
        self.contents = content
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = stackView
        add(contents: contents)
        setConstraints(contents:contents)
    }
    
    private func add(contents:[UIViewController]){
        for content in contents {
            stackView.addArrangedSubview(content.view)
        }
    }
    
    private func setConstraints(contents:[UIViewController]) {
        for content in contents {
            addConstraints(content)
        }
    }
    
    private func addConstraints(_ content:UIViewController) {
        
        let contentSize = content.view.frame.size
        var height = contentSize.height
        var width = contentSize.width

        if content.preferredContentSize != .zero {
            let size = content.preferredContentSize
            height = size.height
            width = size.width
        }
        
        portraitConstraints.append(contentsOf: [
            content.view.heightAnchor.constraint(equalToConstant: height),
            content.view.widthAnchor.constraint(equalToConstant: width)
            ])
        
        _ = portraitConstraints.map{ $0.priority = .defaultHigh }
        updateStackViewAxis()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Stack View"
    }

    private func updateStackViewAxis() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            stackView.axis = .horizontal
        default:
            stackView.axis = .vertical
            if portraitConstraints.isEmpty {
                setConstraints(contents: contents)
            }
            NSLayoutConstraint.activate(portraitConstraints)
        }
    }

    private func printStackViewSize(){
        print("stack view frame", stackView.frame)
        print("stack view bounds", stackView.bounds)
    }
    
    private func printContentSize(content:UIViewController) {
        print("screen bounds: ", UIScreen.main.bounds)
        print("content frame: ", content.view.frame)
        print("content bounds: ", content.view.bounds)
        print("content intrinsicContentSize: ", content.view.intrinsicContentSize)
    }
        
    /* change the stackviews axis when the device rotates */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        updateStackViewAxis()
    }
}
