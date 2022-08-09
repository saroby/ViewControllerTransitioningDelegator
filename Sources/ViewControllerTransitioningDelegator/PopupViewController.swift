import UIKit


public class PopupViewController: UIViewController {
    
    let delegator: PopupControllerTransitionDelegator
    var backgroundTappedClosure: ((PopupViewController) -> Void)?
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(
        view: UIView,
        presentAnimation: PopupControllerTransitionDelegator.PresentAnimation,
        presentAnimationDuration: TimeInterval,
        dismissAnimation: PopupControllerTransitionDelegator.DismissAnimation,
        dismissAnimationDuration: TimeInterval,
        parentAnchor: ParentAnchor = .center,
        offsetY: CGFloat = .zero,
        backgroundTappedClosure: ((PopupViewController) -> Void)? = backgroundTappedDismissClosure
    ) {
        self.delegator = .init(
            presentAnimation: presentAnimation,
            presentAnimationDuration: presentAnimationDuration,
            dismissAnimation: dismissAnimation,
            dismissAnimationDuration: dismissAnimationDuration,
            backgroundColor: .black.withAlphaComponent(0.7)
        )
        super.init(nibName: nil, bundle: nil)
        
        self.transitioningDelegate = self.delegator
        self.modalPresentationStyle = .custom
        
        self.view.addSubview(view)
        
        switch parentAnchor {
        case .center:
            view.center = .init(
                x: self.view.center.x,
                y: self.view.center.y + offsetY
            )
            
        case .bottom:
            view.center = .init(
                x: self.view.center.x,
                y: self.view.frame.height - (view.frame.height / 2) + offsetY
            )
            view.autoresizingMask = [.flexibleBottomMargin]
            
        }
        
        if let backgroundTappedClosure = backgroundTappedClosure {
            self.backgroundTappedClosure = backgroundTappedClosure
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBackgroundTapped(_:))))
        }
    }
    
    @objc private func onBackgroundTapped(_ sender: UITapGestureRecognizer) {
        self.backgroundTappedClosure?(self)
    }
}


extension PopupViewController {
    
    public enum ParentAnchor {
        case center
        case bottom
    }
    
    public static let backgroundTappedDismissClosure: ((PopupViewController) -> Void)? = { vc in
        vc.dismiss(animated: true)
    }
    
}
