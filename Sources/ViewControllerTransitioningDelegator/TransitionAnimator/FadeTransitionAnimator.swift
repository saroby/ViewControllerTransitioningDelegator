import UIKit


final class FadeTransitionAnimator: TransitionAnimator {
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        switch direction {
        case .in:
            to.view.alpha = 0
            UIView.animate(
                withDuration: self.duration,
                delay: 0,
                options: [.curveEaseOut]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.to.view.alpha = 1
            } completion: { _ in
                transitionContext.completeTransition(true)
            }
            
        case .out:
            UIView.animate(
                withDuration: self.duration,
                delay: 0,
                options: [.curveEaseIn]
            ) { [weak self] in
                guard let self = self else { return }
                
                self.from.view.alpha = 0.0
            } completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            
        }
    }
    
}
