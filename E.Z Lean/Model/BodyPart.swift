//
//  BodyPart.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/5/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation

enum BodyPart: String {
    case
    calf = "Calves",
    hamstring = "Hamstrings",
    quad = "Quadriceps",
    glute = "Glute",
    chest = "Chest",
    lats = "Back",
    shoulder = "Shoulder - Traps",
    biceps = "Biceps",
    triceps = "Triceps",
    forearm = "Forearm",
    core = "Core"
    
    var name: String {
        return self.rawValue
    }
    
    static func getBodyPart(from string: String) -> BodyPart? {
        if string == "Shoulder" || string == "Trapezius" {
            return BodyPart.shoulder
        } else {
            return BodyPart.init(rawValue: string)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .calf:
            return #imageLiteral(resourceName: "calves.png")
        case .hamstring:
            return #imageLiteral(resourceName: "hamstring.png")
        case .quad:
            return #imageLiteral(resourceName: "leg.png")
        case .glute:
            return #imageLiteral(resourceName: "glute.png")
        case .chest:
            return #imageLiteral(resourceName: "chest.png")
        case .lats:
            return #imageLiteral(resourceName: "lats.png")
        case .shoulder:
            return #imageLiteral(resourceName: "shoulder.png")
        case .biceps:
            return #imageLiteral(resourceName: "biceps.png")
        case .triceps:
            return #imageLiteral(resourceName: "triceps.png")
        case .forearm:
            return #imageLiteral(resourceName: "forearm.png")
        case .core:
            return #imageLiteral(resourceName: "core.png")
        }
    }
}
