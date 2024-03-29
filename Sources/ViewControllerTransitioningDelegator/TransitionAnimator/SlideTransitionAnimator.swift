import UIKit


final class SlideTransitionAnimator: TransitionAnimator {
    
    let usingSpringWithDamping: CGFloat
    let initialSpringVelocity: CGFloat
    let options: UIView.AnimationOptions
    
    init(
        direction: AnimationDirection,
        duration: TimeInterval,
        usingSpringWithDamping: CGFloat,
        initialSpringVelocity: CGFloat,
        options: UIView.AnimationOptions
    ) {
        self.usingSpringWithDamping = usingSpringWithDamping
        self.initialSpringVelocity = initialSpringVelocity
        self.options = options
        super.init(direction: direction, duration: duration)
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        let key = self.direction == .in ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        let controller = transitionContext.viewController(forKey: key)!
        let animationDuration = transitionDuration(using: transitionContext)
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        
        if self.direction == .in {
            dismissedFrame.origin.y += presentedFrame.height
            
            transitionContext.containerView.addSubview(controller.view)
        } else {
            dismissedFrame.origin.y += dismissedFrame.height
        }
        
        let initialFrame = self.direction == .in ? dismissedFrame : presentedFrame
        let finalFrame = self.direction == .in ? presentedFrame : dismissedFrame
        
        controller.view.frame = initialFrame
        UIView.animate(
            withDuration: animationDuration,
            delay: 0,
            usingSpringWithDamping: self.usingSpringWithDamping,
            initialSpringVelocity: self.initialSpringVelocity,
            options: self.options,
            animations: {
                controller.view.frame = finalFrame
            }
        ) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
