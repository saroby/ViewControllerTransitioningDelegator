import UIKit


class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var to: UIViewController!
    
    var from: UIViewController!
    
    let duration: TimeInterval
    
    let direction: AnimationDirection
    
    
    init(direction: AnimationDirection, duration: TimeInterval) {
        self.direction = direction
        self.duration = duration
        super.init()
    }
    
    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch direction {
        case .in:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                  let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            else { return }
            
            self.to = to
            self.from = from
            
            let container = transitionContext.containerView
            container.addSubview(to.view)
            
        case .out:
            guard let to = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
                  let from = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            else { return }
            
            self.to = to
            self.from = from
        }
    }
    
}


extension TransitionAnimator {
    
    enum AnimationDirection {
        case `in`
        case out
    }
    
}
