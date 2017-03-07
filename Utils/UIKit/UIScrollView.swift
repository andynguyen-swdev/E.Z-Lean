//
//  UIScrollView.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit

extension UIScrollView {
    public func zoomToPoint(_ zoomPoint: CGPoint, withScale scale: CGFloat, animated: Bool) {
    //Ensure scale is clamped to the scroll view's allowed zooming range
    var scale = min(scale, self.maximumZoomScale);
    scale = max(scale, self.minimumZoomScale);
    
    //`zoomToRect` works on the assumption that the input frame is in relation
    //to the content view when zoomScale is 1.0
    
    //Work out in the current zoomScale, where on the contentView we are zooming
    var translatedZoomPoint = CGPoint.zero;
    translatedZoomPoint.x = zoomPoint.x + self.contentOffset.x;
    translatedZoomPoint.y = zoomPoint.y + self.contentOffset.y;
    
    //Figure out what zoom scale we need to get back to default 1.0f
    let zoomFactor = 1 / self.zoomScale;
    
    //By multiplying by the zoom factor, we get where we're zooming to, at scale 1.0f;
    translatedZoomPoint.x *= zoomFactor;
    translatedZoomPoint.y *= zoomFactor;
    
    //work out the size of the rect to zoom to, and place it with the zoom point in the middle
    var destinationRect = CGRect.zero;
    destinationRect.size.width = self.frame.width / scale;
    destinationRect.size.height = self.frame.height / scale;
    destinationRect.origin.x = translatedZoomPoint.x - (destinationRect.width * 0.5);
    destinationRect.origin.y = translatedZoomPoint.y - (destinationRect.height * 0.5);
    
    self.zoom(to: destinationRect, animated: animated)
    }
}
