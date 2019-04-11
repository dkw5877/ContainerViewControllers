import UIKit

/* protocol to ensure there is a delegate and interactive area */
protocol CardViewProtocol:AnyObject {
    var handle:UIView { get }
    var delegate:CardViewControllerGesturesDelegate? { get set }
}

/* gesture recognizer protocols */
protocol CardViewControllerGesturesDelegate:AnyObject {
    func handleTapGesture(tapGesture: UITapGestureRecognizer)
    func handlePanGesture(panGesture: UIPanGestureRecognizer)
}

final class CardContainerViewController: UIViewController {

    typealias CardViewController = UIViewController & CardViewProtocol
    private let mainViewController:UIViewController
    private let cardViewController:CardViewController
  
    /* public API */
    var cardHeight:CGFloat = 600
    var duration:TimeInterval = 0.9

    private var cardHandleHeight:CGFloat = 30.0
    private var cardMaximumHeight:CGFloat {
        return min(cardHeight, view.frame.height - view.layoutMargins.top)
    }
    
    private var visualEffectView:UIVisualEffectView!
    private var cardVisible = false
    private var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    //holds animations
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterrupted:CGFloat = 0

    required init(mainViewController:UIViewController, cardViewController:CardViewController) {
        self.mainViewController = mainViewController
        self.cardViewController = cardViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Card Container"
        setupMainViewController()
        setupVisualEffectView()
        setupCard()
    }
        
    private func setupMainViewController() {
        addChild(mainViewController)
        view.addSubview(mainViewController.view)
        mainViewController.view.frame = view.frame
        mainViewController.didMove(toParent: self)
    }
    
    private func setupVisualEffectView() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = view.bounds
        view.addSubview(visualEffectView)
    }
    
    /* setup card view controller as child view controller */
    private func setupCard() {
        
        cardViewController.delegate = self
        add(child: cardViewController, in: view)
        
        /* get the card handle & set frame */
        setCardFrame()
        cardViewController.view.clipsToBounds = true
        cardViewController.didMove(toParent: self)
    }
    
    /*
     * we need to setup the card's frame initially, and then update it after the margins
     * are set by the system. We do this in viewDidLayoutSubviews
     **/
    private func setCardFrame() {
        cardHandleHeight = cardViewController.handle.frame.height
        let yOrigin = cardYOriginWhenCollapsed()
        cardViewController.view.frame = CGRect(x: 0, y: yOrigin, width: view.frame.width, height: cardMaximumHeight)
        visualEffectView.frame = view.bounds
    }
    
    private func cardYOriginWhenCollapsed() -> CGFloat {
        return view.frame.height - view.layoutMargins.bottom - cardHandleHeight
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCardFrame()
    }
    
    /*
     * we dismiss the card view when the device rotates
     */
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        animateCardFrame(duration, .collapsed)
        animateBlurView(duration, .collapsed)
    }
}

extension CardContainerViewController : CardViewControllerGesturesDelegate {
    
    func handleTapGesture(tapGesture gesture:UITapGestureRecognizer){
        switch  gesture.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: duration)
        default:break
        }
    }
    
    func handlePanGesture(panGesture gesture:UIPanGestureRecognizer) {
        switch  gesture.state {
        case .began:
            startInteractiveTransition(state: nextState, duration:duration)
        case .changed:
            let translation = gesture.translation(in: cardViewController.handle)
            var fractionComplete = translation.y / cardMaximumHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:break
        }
    }
    
    func animateTransitionIfNeeded(state:CardState, duration:TimeInterval){
        if runningAnimations.isEmpty {
            animateCardFrame(duration, state)
            animateCornerRadius(duration, state)
            animateBlurView(duration, state)
        }
    }
    
    fileprivate func animateCardFrame(_ duration: TimeInterval, _ state: CardState) {
        let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
            switch state {
            case .expanded:
                self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardMaximumHeight
            case .collapsed:
                self.cardViewController.view.frame.origin.y = self.cardYOriginWhenCollapsed()
            }
        }
        
        frameAnimator.addCompletion{ _ in
            self.cardVisible.toggle()
            self.runningAnimations.removeAll()
        }
        
        frameAnimator.startAnimation()
        runningAnimations.append(frameAnimator)
    }
    
    fileprivate func animateCornerRadius(_ duration: TimeInterval, _ state: CardState) {
        let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
            switch state {
            case .expanded:
                self.cardViewController.view.layer.cornerRadius = 12
            case .collapsed:
                self.cardViewController.view.layer.cornerRadius = 0
            }
        }
        
        cornerRadiusAnimator.startAnimation()
        runningAnimations.append(cornerRadiusAnimator)
    }
    
    fileprivate func animateBlurView(_ duration:TimeInterval, _ state:CardState) {
        let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1.0) {
            switch state {
            case .expanded:
                self.visualEffectView.effect = UIBlurEffect(style: .dark)
            case .collapsed:
                self.visualEffectView.effect = nil
            }
        }
        
        blurAnimator.startAnimation()
        runningAnimations.append(blurAnimator)
        
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval){
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat){
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted +  animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition() {
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
}

