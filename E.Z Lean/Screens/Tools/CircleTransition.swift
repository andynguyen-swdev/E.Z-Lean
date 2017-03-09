import UIKit
import Utils

class CircularTransition: NSObject {
    
    var startingPoint = CGPoint.zero
    var circleColor = UIColor.white
    
    var duration = 0.3 as Double
    var circle: UIView!
    
    enum CircularTransitionMode:Int {
        case present, dismiss, pop
    }
    
    var transitionMode:CircularTransitionMode = .present
    
    deinit {
        print("Deinit-CircularTransition")
    }
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: .to)!
        let toVC = transitionContext.viewController(forKey: .to)!
        toView.frame = transitionContext.finalFrame(for: toVC)
        
        circle = UIView()
        circle.backgroundColor = circleColor
        
        let size = AppDelegate.instance.window!.frame.size
        let radius = sqrt(size.width*size.width + size.height*size.height)
        
        circle.frame.size = CGSize(width: radius*2, height: radius*2)
        circle.layer.cornerRadius = radius
        
        circle.center = startingPoint
        circle.transform = .init(scaleX: 17 / radius, y: 17 / radius)
        
        let snapshot = UIView(frame: toView.frame)
        snapshot.alpha = 0.99
        snapshot.layer.mask = circle.layer
        snapshot.layer.addSublayer(toView.layer)
        containerView.addSubview(snapshot)
        
        UIView.animate(withDuration: duration, animations: { [unowned self] in
            self.circle.transform = .identity
            snapshot.alpha = 1
        }, completion: { completed in
            print(completed)
            containerView.addSubview(toView)
            transitionContext.completeTransition(completed)
        })
    }
}
