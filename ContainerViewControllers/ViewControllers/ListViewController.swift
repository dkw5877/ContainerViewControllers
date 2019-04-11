import UIKit

final class ListViewController: UIViewController {

    weak var delegate:ListViewControllerDelegate?
    private let loadingController = LoadingViewController()
    private let tableView = UITableView()
    private let listLoader:ListLoader
    private var dataSource:ListDataSource?
    private var previewingItem:ItemViewModel?
    
    init(listLoader:ListLoader){
        self.listLoader = listLoader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deallocing \(self)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        add(child: loadingController)
        loadData()
    }
    
    private func configureTableView() {
        //add peek & pop functionality
        registerForPreviewing(with: self, sourceView: tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        layoutTableView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutTableView()
    }
    
    private func layoutTableView(){
        var contentSize = tableView.contentSize
        contentSize.height += view.frame.origin.y
        tableView.contentSize = contentSize
        tableView.frame = view.frame
    }
    
    private func loadData() {
        listLoader.loadItems { (items) in
            if let items = items {
                self.dataSource = ListDataSource(viewModels: items)
                DispatchQueue.main.async {
                    self.tableView.dataSource = self.dataSource
                    self.tableView.reloadData()
                    self.remove(child: self.loadingController)
                }
            }
        }
    }
}

extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource?.item(at: indexPath) else { return }
        delegate?.didSelectItem(item: item)
    }
}

 /**
 * peek and pop behavior
 */
extension ListViewController : UIViewControllerPreviewingDelegate {
    
    /*
     * Called to let you prepare the presentation of a commit (pop) view from your commit view
     * controller.
     * @param The context object for the previewing view controller.
     * @param The location of the touch in the source view’s coordinate system.
     * @note we need to create an instance of the detail view controller
     */
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {

        if let indexPath = tableView.indexPathForRow(at: location) {
            previewingItem = dataSource?.item(at: indexPath) ?? nil
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            return getDetailViewController(for: indexPath)
        }
        
        return nil
    }
    
    /*
     * Called when the user has pressed a source view in a previewing view controller,
     * thereby obtaining a surrounding blur to indicate that a preview (peek) is available.
     * @param The context object for the previewing view controller.
     * @param The view controller whose view your implementation of this method is moving
     * into place as a commit (pop) view.
     * @note Here we just send the normal didSelectItem delegat call to the coordinator
     */
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let previewingItem = previewingItem {
            delegate?.didSelectItem(item: previewingItem)
        }
    }
    
    /**
     *
    */
    private func getDetailViewController(for indexPath:IndexPath) -> UIViewController? {
        if let item = dataSource?.item(at: indexPath) {
            let imageLoader = ImageLoader.imageLoader(urlString: item.url)
            let viewController = ListDetailViewController(imageLoader: imageLoader, item: item)
            return viewController
        }
       return nil
    }
    
}
