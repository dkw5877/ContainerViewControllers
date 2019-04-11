import UIKit

final class UserProfileViewController: UIViewController {

    private var profileView = UserProfileView()
    private let viewModel:ProfileViewModel

    init(viewModel:ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        profileView.bounds = UIScreen.main.bounds
        view = profileView
        preferredContentSize = view.intrinsicContentSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.image = UIImage(named: viewModel.imageName)
        profileView.name = viewModel.name
        profileView.quote = viewModel.quote
    }

}
