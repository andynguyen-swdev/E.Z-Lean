//
//  BodyPart.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation

enum BodyPart {
    case calf, hamstring, quad, glute, chest, lats, shoulder, biceps, triceps, forearm, core
    
    var name: String {
        switch self {
        case .calf:
            return "Calf"
        case .hamstring:
            return "Hamstring"
        case .quad:
            return "Quadriceps"
        case .glute:
            return "Hip - Glute"
        case .chest:
            return "Chest"
        case .lats:
            return "Lats"
        case .shoulder:
            return "Shoulders - Traps"
        case .biceps:
            return "Biceps"
        case .triceps:
            return "Triceps"
        case .forearm:
            return "Forearm"
        case .core:
            return "Core"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .calf:
            return nil
        case .hamstring:
            return #imageLiteral(resourceName: "hamstring.png")
        case .quad:
            return #imageLiteral(resourceName: "leg.png")
        case .glute:
            return #imageLiteral(resourceName: "glute.png")
        case .chest:
            return #imageLiteral(resourceName: "chest.png")
        case .lats:
            return #imageLiteral(resourceName: "back.png")
        case .shoulder:
            return #imageLiteral(resourceName: "shoulder.png")
        case .biceps:
            return #imageLiteral(resourceName: "biceps.png")
        case .triceps:
            return #imageLiteral(resourceName: "triceps.png")
        case .forearm:
            return nil
        case .core:
            return #imageLiteral(resourceName: "core.png")
        }
    }
}
