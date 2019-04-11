import UIKit

final class StoryViewController: UIViewController {

    var labelColor:UIColor = Theme.redSky {
        didSet {
            storyView.labelColor = labelColor
        }
    }
    
    private var storyView = StoryView()
    private let viewModel:StoryViewModel
    
    init(viewModel:StoryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        storyView.bounds = UIScreen.main.bounds
        view = storyView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        storyView.image = UIImage(named: viewModel.imageName)
        storyView.text = viewModel.text
        storyView.content = viewModel.content
    }
}
