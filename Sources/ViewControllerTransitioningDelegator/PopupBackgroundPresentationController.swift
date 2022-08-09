import UIKit


final class PopupBackgroundPresentationController: UIPresentationController {
    
    let backgroundColor: UIColor
    
    lazy var overlay: PopupDialogOverlayView = {
        let v = PopupDialogOverlayView(frame: .zero)
        v.color = self.backgroundColor
        return v
    }()
    
    
    init(presentedViewController: UIViewController, presenting: UIViewController?, backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        super.init(presentedViewController: presentedViewController, presenting: presenting)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }
        
        self.overlay.frame = containerView.bounds
        containerView.insertSubview(self.overlay, at: 0)
        
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { [weak self] _ in
                self?.overlay.alpha = 1.0
            },
            completion: nil
        )
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(
            alongsideTransition: { [weak self] _ in
                self?.overlay.alpha = 0.0
            },
            completion: nil
        )
    }
    
    override func containerViewWillLayoutSubviews() {
        guard let presentedView = self.presentedView else { return }
        
        presentedView.frame = frameOfPresentedViewInContainerView
    }
    
}
