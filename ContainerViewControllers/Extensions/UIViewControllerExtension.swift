//
//  UIViewControllerExtension.swift
//  SwiftCommonComponents
//
//
import UIKit

extension UIViewController {
    
    /* add child controller */
    func add(child childViewController: UIViewController) {
        beginAddChild(child: childViewController)
        view.addSubview(childViewController.view)
        endAddChild(child: childViewController)
    }
    
    /* add child controller in a specific view */
    func add(child childViewController: UIViewController, in view: UIView) {
        beginAddChild(child: childViewController)
        view.addSubview(childViewController.view)
        endAddChild(child: childViewController)
    }
    
    /* add child controller in a specific view with a set frame */
    func add(child childViewController: UIViewController, in view: UIView, with frame:CGRect) {
        beginAddChild(child: childViewController)
        childViewController.view.frame = frame
        view.addSubview(childViewController.view)
        endAddChild(child: childViewController)
    }

    /* remove child controller */
    func remove(child childViewController:UIViewController){
        guard parent != nil else { return }
        childViewController.beginAppearanceTransition(false, animated: false)
        childViewController.willMove(toParent: nil)
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
        childViewController.endAppearanceTransition()
    }
    
    /* extract these common methods out to avoid code duplication */
    private func beginAddChild(child childViewController:UIViewController){
        childViewController.beginAppearanceTransition(true, animated: false)
        self.addChild(childViewController)
    }
    
    private func endAddChild(child childViewController:UIViewController){
        childViewController.didMove(toParent: self)
        childViewController.endAppearanceTransition()
    }
    
    /* standard fade transition between view controllers */
    func transition(to child:UIViewController, completion:((Bool)-> Void)? = nil){
        let duration = 0.25
        let current = children.last
        addChild(child)
        
        let newView = child.view!
        newView.translatesAutoresizingMaskIntoConstraints = true
        newView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        newView.frame = view.bounds
        
        if let existing = current {
            existing.willMove(toParent: nil)
            transition(from: existing, to: child, duration: duration, options: [.transitionCrossDissolve], animations:{}) { (done) in
                existing.removeFromParent()
                child.didMove(toParent: self)
                completion?(done)
            }
        } else {
            view.addSubview(newView)
            UIView.animate(withDuration: duration, delay: 0, options: [.transitionCrossDissolve], animations: {}) { (done) in
                child.didMove(toParent: self)
                completion?(done)
            }
        }
    }
}

/* let the top view controller decide if it should rotate or not */
extension UINavigationController {
    
    open override var shouldAutorotate: Bool {
        if let shouldAutorotate = visibleViewController?.shouldAutorotate {
            return shouldAutorotate
        } else {
            return true
        }
    }
}

/* let tabbar selected view controller decide if it should rotate or not */
extension UITabBarController {

    open override var shouldAutorotate:Bool {
        if let selected = selectedViewController {
            return selected.shouldAutorotate
        }
        return true
    }
}
