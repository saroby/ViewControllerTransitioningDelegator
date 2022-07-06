import UIKit


final class FadeTransitionAnimator: TransitionAnimator {
    
    
    init(direction: AnimationDirection) {
        super.init(
            inDuration: 0.3,
            outDuration: 0.2,
            direction: direction
        )
    }
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        super.animateTransition(using: transitionContext)
        
        switch direction {
        case .in:
            to.view.alpha = 0
            UIView.animate(
                withDuration: 0.6,
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
                withDuration: outDuration,
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
