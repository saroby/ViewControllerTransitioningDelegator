import UIKit


open class PopupControllerTransitionDelegator: NSObject, UIViewControllerTransitioningDelegate {
    
    let presentAnimation: PresentAnimation
    
    let presentAnimationDuration: TimeInterval
    
    let dismissAnimation: DismissAnimation
    
    let dismissAnimationDuration: TimeInterval
    
    let backgroundColor: UIColor
    
    
    public init(
        presentAnimation: PresentAnimation,
        presentAnimationDuration: TimeInterval,
        dismissAnimation: DismissAnimation,
        dismissAnimationDuration: TimeInterval,
        backgroundColor: UIColor
    ) {
        self.presentAnimation = presentAnimation
        self.presentAnimationDuration = presentAnimationDuration
        self.dismissAnimation = dismissAnimation
        self.dismissAnimationDuration = dismissAnimationDuration
        self.backgroundColor = backgroundColor
        super.init()
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopupBackgroundPresentationController(
            presentedViewController: presented,
            presenting: source,
            backgroundColor: self.backgroundColor
        )
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch self.presentAnimation {
        case .fadeIn:
            return FadeTransitionAnimator(direction: .in, duration: self.presentAnimationDuration)
        case let .up(usingSpringWithDamping, initialSpringVelocity, options):
            return SlideTransitionAnimator(
                direction: .in,
                duration: self.presentAnimationDuration,
                usingSpringWithDamping: usingSpringWithDamping,
                initialSpringVelocity: initialSpringVelocity,
                options: options
            )
        }
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch self.dismissAnimation {
        case .fadeOut:
            return FadeTransitionAnimator(direction: .out, duration: self.dismissAnimationDuration)
        case let .down(usingSpringWithDamping, initialSpringVelocity, options):
            return SlideTransitionAnimator(
                direction: .out,
                duration: self.dismissAnimationDuration,
                usingSpringWithDamping: usingSpringWithDamping,
                initialSpringVelocity: initialSpringVelocity,
                options: options
            )
        }
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
}


extension PopupControllerTransitionDelegator {
    
    public enum PresentAnimation {
        case fadeIn
        case up(usingSpringWithDamping: CGFloat = 0.7, initialSpringVelocity: CGFloat = 0, options: UIView.AnimationOptions = [])
    }
    
    public enum DismissAnimation {
        case fadeOut
        case down(usingSpringWithDamping: CGFloat = 0.7, initialSpringVelocity: CGFloat = 0, options: UIView.AnimationOptions = [])
    }
    
}
