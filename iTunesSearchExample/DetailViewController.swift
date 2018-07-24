//
//  DetailViewController.swift
//  iTunesSearchExample
//
//  Created by komu on 2018/07/23.
//  Copyright © 2018年 Shohei Komura. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, Storyboardable {
    @IBOutlet weak var imageView: UIImageView!



}

class MyTransitionDelegate : NSObject, UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        return MyPresentedAnimater()
    }
    
    
    //    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    //    {
    //        return MyDismissedAnimater()
    //    }
}

class MyPresentedAnimater : NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let container = transitionContext.containerView
        
        guard let approotViewController = fromVC.childViewControllers.first as? AppRootViewController,
            let searchViewController = approotViewController.childVC as? SearchArtistViewController else { return }
        

        let imageView = searchViewController.copyImageView()
        let destImageViewRect = (toVC as! DetailViewController).imageView.frame

        container.addSubview(toVC.view)
        toVC.view.layoutIfNeeded()
        container.addSubview(imageView)
        toVC.view.alpha = 0.0

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.frame = destImageViewRect
            searchViewController.selecedImageView.isHidden = true
            toVC.view.alpha = 1.0

        }, completion: {_ in transitionContext.completeTransition(true)
        })

    }
}
