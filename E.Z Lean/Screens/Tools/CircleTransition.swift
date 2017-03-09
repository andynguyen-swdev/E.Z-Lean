import UIKit
import Utils

class CircularTransition: NSObject {
    
    var startingPoint = CGPoint.zero
    var circleColor = UIColor.white
    
    var duration = 0.5 as Double
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
        
        let fromView = transitionContext.view(forKey: .from)!
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
        
        if transitionMode == .present {
            circle.transform = .init(scaleX: 17 / radius, y: 17 / radius)
            
            let placeHolder = UIView(frame: toView.bounds)
            placeHolder.alpha = 0.99
            placeHolder.layer.mask = circle.layer
            placeHolder.layer.addSublayer(toView.layer)
            containerView.addSubview(placeHolder)
            
            UIView.animate(withDuration: duration, animations: { [unowned self] in
                self.circle.transform = .identity
                placeHolder.alpha = 1
                }, completion: { completed in
                    containerView.addSubview(toView)
                    transitionContext.completeTransition(completed)
            })
        }
        else if transitionMode == .pop {
            containerView.addSubview(toView)
            containerView.sendSubview(toBack: toView)
            
            fromView.layer.mask = circle.layer
            fromView.alpha = 0.99
            
            UIView.animate(withDuration: duration, animations: { [unowned self] in
                fromView.alpha = 1
                self.circle.transform = .init(scaleX: 17 / radius, y: 17 / radius)
            }) { completed in
                fromView.removeFromSuperview()
                containerView.bringSubview(toFront: toView)
                transitionContext.completeTransition(completed)
            }
        } 
    }
}
