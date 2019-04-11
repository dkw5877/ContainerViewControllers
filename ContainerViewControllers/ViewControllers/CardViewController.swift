
import UIKit

final class CardViewController: UIViewController, CardViewProtocol {
    
    var handleArea: UIView!
    
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dmitriy-ilkevich-boots")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    weak var delegate: CardViewControllerGesturesDelegate?
    var handle: UIView { return handleArea }
    
    deinit {
        print("deallocing \(self)")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupViews()
        setupGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViewFrames()
    }
    
    private func setupViews() {
        handleArea = HandleView(frame: .zero)
        handleArea.backgroundColor = Theme.mainColor
        view.addSubview(imageView)
        view.addSubview(handleArea)
        setupViewFrames()
    }
    
    private func setupViewFrames() {
        handleArea.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30.0)
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(gesture:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(gesture:)))
        handleArea.addGestureRecognizer(tapGesture)
        handleArea.addGestureRecognizer(panGesture)
    }
    
    @objc func handleCardTap(gesture:UITapGestureRecognizer){
        delegate?.handleTapGesture(tapGesture: gesture)
    }
    
    @objc func handleCardPan(gesture:UIPanGestureRecognizer) {
        delegate?.handlePanGesture(panGesture: gesture)
    }
}
