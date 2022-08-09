import UIKit


final class PopupDialogOverlayView: UIView {
    
    // MARK: - Appearance
    
    /// The background color of the overlay view
    @objc public dynamic var color: UIColor? {
        get { return overlay.backgroundColor }
        set { overlay.backgroundColor = newValue }
    }
    
    // MARK: - Views
    
    internal lazy var overlay: UIView = {
        let overlay = UIView(frame: .zero)
        overlay.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return overlay
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.sharedInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.sharedInit()
    }
    
    private func sharedInit() {
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor = .clear
        self.alpha = 0
        self.addSubview(overlay)
    }
    
}
