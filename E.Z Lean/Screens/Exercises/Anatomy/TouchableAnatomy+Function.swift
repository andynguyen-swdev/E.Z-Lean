//
//  TouchableAnatomy+Function.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/1/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import RxGesture

extension TouchableAnatomy {
    func config() {
//        self.rx.tapGesture(numberOfTouchesRequired: 1, numberOfTapsRequired: 1, configuration: nil)
//            .subscribe(onNext: { [unowned self] gesture in
//                let location = gesture.location(in: self)
//                self.currentBodyPart.value = self.getTouchedPart(location: location)
//            })
//            .addDisposableTo(disposeBag)
    }
    
    func selectBodyPart(_ bodyPart: BodyPart?) {
        guard let bodyPart = bodyPart else { return }
        self.currentBodyPart.value = bodyPart
    }
    
    func touched(at location: CGPoint) {
        if let bodyPart = getTouchedPart(location: location) {
            self.currentBodyPart.value = bodyPart
        }
    }
    
    func getTouchedPart(location: CGPoint) -> BodyPart? {
        if location.isIn(calfPaths) {
            return .calf
        }
        if location.isIn(hamstringPaths) {
            return .hamstring
        }
        if location.isIn(quadPaths) {
            return .quad
        }
        if location.isIn(glutePaths) {
            return .glute
        }
        if location.isIn(chestPaths) {
            return .chest
        }
        if location.isIn(latsPaths) {
            return .lats
        }
        if location.isIn(deltPaths, rotatorCuffPaths, lowerTrapPaths, middleTrapPaths, upperTrapPaths) {
            return .shoulder
        }
        if location.isIn(bicepsPaths) {
            return .biceps
        }
        if location.isIn(tricepsPaths) {
            return .triceps
        }
        if location.isIn(forearmPaths) {
            return .forearm
        }
        if location.isIn(corePaths, lowerBackPaths) {
            return .core
        }
        return nil
    }
}

extension CGPoint {
    fileprivate func isIn(_ paths: [UIBezierPath]) -> Bool {
        for path in paths {
            if path.contains(self) {
                return true
            }
        }
        return false
    }
    fileprivate func isIn(_ pathArrays: [[UIBezierPath]]) -> Bool {
        let array = pathArrays.flatMap {
            return $0
        }
        return isIn(array)
    }
    fileprivate func isIn(_ pathArrays: [UIBezierPath]...) -> Bool {
        return isIn(pathArrays)
    }
}
