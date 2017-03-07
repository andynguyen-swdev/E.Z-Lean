//
//  TouchableAnatomy.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/1/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import UIKit
import RxSwift

class TouchableAnatomy: UIControl {
    var currentBodyPart: Variable<BodyPart?> = Variable(nil)
    var disposeBag = DisposeBag()
    
	// Calf
	var calfLeftPath: UIBezierPath!
	var calfLeft2Path: UIBezierPath!
	var calfLeft3Path: UIBezierPath!
	var calfRightPath: UIBezierPath!
	var calfRight2Path: UIBezierPath!
	var calfRight3Path: UIBezierPath!
	var calfPaths: [UIBezierPath] {
		return [calfLeftPath, calfLeft2Path, calfLeft3Path, calfRightPath, calfRight2Path, calfRight3Path]
	}
	// Hamstring
	var hamstringLeftPath: UIBezierPath!
	var hamstringLeft2Path: UIBezierPath!
	var hamstringLeft3Path: UIBezierPath!
	var hamstringRightPath: UIBezierPath!
	var hamstringRight2Path: UIBezierPath!
	var hamstringRight3Path: UIBezierPath!
	var hamstringPaths: [UIBezierPath] {
		return [hamstringLeftPath, hamstringLeft2Path, hamstringLeft3Path, hamstringRightPath, hamstringRight2Path, hamstringRight3Path]
	}
	// Quad
	var quadLeftPath: UIBezierPath!
	var quadLeft2Path: UIBezierPath!
	var quadLeft3Path: UIBezierPath!
	var quadLeft4Path: UIBezierPath!
	var quadRightPath: UIBezierPath!
	var quadRight2Path: UIBezierPath!
	var quadRight3Path: UIBezierPath!
	var quadRight4Path: UIBezierPath!
	var quadPaths: [UIBezierPath] {
		return [quadLeftPath, quadLeft2Path, quadLeft3Path, quadLeft4Path, quadRightPath, quadRight2Path, quadRight3Path, quadRight4Path]
	}
	// Forearm
	var forearmLeftPath: UIBezierPath!
	var foreArmRightPath: UIBezierPath!
	var forearmLeft2Path: UIBezierPath!
	var forearmRight2Path: UIBezierPath!
	var forearmPaths: [UIBezierPath] {
		return [forearmLeftPath, forearmLeft2Path, foreArmRightPath, forearmRight2Path]
	}
	// Glute
	var glutePath: UIBezierPath!
	var glutePaths: [UIBezierPath] {
		return [glutePath]
	}
	// Core
	var corePath: UIBezierPath!
	var coreLeftPath: UIBezierPath!
	var coreLeft2Path: UIBezierPath!
	var coreLeft3Path: UIBezierPath!
	var coreRightPath: UIBezierPath!
	var coreRight2Path: UIBezierPath!
	var corePaths: [UIBezierPath] {
		return [corePath, coreLeftPath, coreLeft2Path, coreLeft3Path, coreRightPath, coreRight2Path]
	}
	// Biceps
	var bicepsLeftPath: UIBezierPath!
	var bicepsLeft2Path: UIBezierPath!
	var bicepsRightPath: UIBezierPath!
	var bicepsRight2Path: UIBezierPath!
	var bicepsPaths: [UIBezierPath] {
		return [bicepsLeftPath, bicepsLeft2Path, bicepsRightPath, bicepsRight2Path]
	}
	// Triceps
	var tricepsLeftPath: UIBezierPath!
	var tricepsRightPath: UIBezierPath!
	var tricepsPaths: [UIBezierPath] {
		return [tricepsLeftPath, tricepsRightPath]
	}
	// Lower Back 
	var lowerBackPath: UIBezierPath!
	var lowerBackPaths: [UIBezierPath] {
		return [lowerBackPath]
	}
	// Lats
	var latsLeftPath: UIBezierPath!
	var latsRightPath: UIBezierPath!
	var latsPaths: [UIBezierPath] {
		return [latsLeftPath, latsRightPath]
	}
	// Rotator Cuff 
	var rotatorCuffLeftPath: UIBezierPath!
	var rotatorCuffRightPath: UIBezierPath!
	var rotatorCuffPaths: [UIBezierPath] {
		return [rotatorCuffLeftPath, rotatorCuffRightPath]
	}
	// Lower Trap
	var lowerTrapLeftPath: UIBezierPath!
	var lowerTrapRightPath: UIBezierPath!
	var lowerTrapPaths: [UIBezierPath] {
		return [lowerTrapLeftPath, lowerTrapRightPath]
	}
	// Middle Trap
	var middleTrapLeftPath: UIBezierPath!
	var middleTrapRightPath: UIBezierPath!
	var middleTrapPaths: [UIBezierPath] {
		return [middleTrapLeftPath, middleTrapRightPath]
	}
	// Upper Trap
	var upperTrapLeftPath: UIBezierPath!
	var upperTrapLeft2Path: UIBezierPath!
	var upperTrapRightPath: UIBezierPath!
	var upperTrapRight2Path: UIBezierPath!
	var upperTrapPaths: [UIBezierPath] {
		return [upperTrapLeftPath, upperTrapLeft2Path, upperTrapRightPath, upperTrapRight2Path]
	}
	// Chest
	var lowerChestLeftPath: UIBezierPath!
	var lowerChestRightPath: UIBezierPath!
	var upperChestLeftPath: UIBezierPath!
	var upperChestRightPath: UIBezierPath!
	var chestPaths: [UIBezierPath] {
		return [lowerChestLeftPath, lowerChestRightPath, upperChestLeftPath, upperChestRightPath]
	}
	// Delt
	var frontDeltLeftPath: UIBezierPath!
	var frontDeltRightPath: UIBezierPath!
	var sideDeltLeftPath: UIBezierPath!
	var sideDeltLeft2Path: UIBezierPath!
	var sideDeltRightPath: UIBezierPath!
	var sideDeltRight2Path: UIBezierPath!
	var rearDeltLeftPath: UIBezierPath!
	var rearDeltRightPath: UIBezierPath!
	var deltPaths: [UIBezierPath] {
		return [frontDeltLeftPath, frontDeltRightPath,
		sideDeltLeftPath, sideDeltLeft2Path, sideDeltRightPath, sideDeltRight2Path,
		rearDeltLeftPath, rearDeltRightPath]
	}

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 700, height: 816)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createPath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createPath()
    }
    
    func createPath() {
	    //// ForearmLeft Drawing
	forearmLeftPath = UIBezierPath()
	forearmLeftPath.move(to: CGPoint(x: 278.14, y: 286.38))
	forearmLeftPath.addLine(to: CGPoint(x: 285.49, y: 278.69))
	forearmLeftPath.addLine(to: CGPoint(x: 293.94, y: 284.19))
	forearmLeftPath.addLine(to: CGPoint(x: 299.46, y: 270.75))
	forearmLeftPath.addLine(to: CGPoint(x: 306.74, y: 258.9))
	forearmLeftPath.addLine(to: CGPoint(x: 310.86, y: 243.39))
	forearmLeftPath.addLine(to: CGPoint(x: 312.45, y: 254.87))
	forearmLeftPath.addLine(to: CGPoint(x: 314.53, y: 270.19))
	forearmLeftPath.addLine(to: CGPoint(x: 316.74, y: 275.03))
	forearmLeftPath.addLine(to: CGPoint(x: 319.11, y: 305.49))
	forearmLeftPath.addLine(to: CGPoint(x: 320.17, y: 367.37))
	forearmLeftPath.addLine(to: CGPoint(x: 312.1, y: 364.72))
	forearmLeftPath.addLine(to: CGPoint(x: 301.18, y: 363.69))
	forearmLeftPath.addLine(to: CGPoint(x: 298.48, y: 365.77))
	forearmLeftPath.addLine(to: CGPoint(x: 283.27, y: 324.52))
	forearmLeftPath.addLine(to: CGPoint(x: 279.24, y: 305.56))
	forearmLeftPath.addLine(to: CGPoint(x: 278.14, y: 286.38))
	forearmLeftPath.close()
	



	//// ForeArm Right Drawing
	foreArmRightPath = UIBezierPath()
	foreArmRightPath.move(to: CGPoint(x: 111.26, y: 263.54))
	foreArmRightPath.addLine(to: CGPoint(x: 106.49, y: 273.08))
	foreArmRightPath.addLine(to: CGPoint(x: 103.55, y: 281.74))
	foreArmRightPath.addLine(to: CGPoint(x: 98.52, y: 295.3))
	foreArmRightPath.addLine(to: CGPoint(x: 97.66, y: 305.81))
	foreArmRightPath.addLine(to: CGPoint(x: 95.09, y: 321.44))
	foreArmRightPath.addLine(to: CGPoint(x: 87, y: 363.71))
	foreArmRightPath.addLine(to: CGPoint(x: 93.74, y: 364.06))
	foreArmRightPath.addLine(to: CGPoint(x: 106.85, y: 369.07))
	foreArmRightPath.addLine(to: CGPoint(x: 118.25, y: 350.38))
	foreArmRightPath.addLine(to: CGPoint(x: 130.99, y: 329.38))
	foreArmRightPath.addLine(to: CGPoint(x: 138.46, y: 312.88))
	foreArmRightPath.addLine(to: CGPoint(x: 142.75, y: 298.23))
	foreArmRightPath.addLine(to: CGPoint(x: 142.75, y: 281.13))
	foreArmRightPath.addLine(to: CGPoint(x: 131.23, y: 275.64))
	foreArmRightPath.addLine(to: CGPoint(x: 115.67, y: 288.26))
	foreArmRightPath.addLine(to: CGPoint(x: 111.38, y: 276.86))
	foreArmRightPath.addLine(to: CGPoint(x: 111.26, y: 263.54))
	foreArmRightPath.close()
	



	//// CalfRight2 Drawing
	calfRight2Path = UIBezierPath()
	calfRight2Path.move(to: CGPoint(x: 147.28, y: 554.11))
	calfRight2Path.addLine(to: CGPoint(x: 152.67, y: 586.35))
	calfRight2Path.addLine(to: CGPoint(x: 155.37, y: 604.43))
	calfRight2Path.addLine(to: CGPoint(x: 157.58, y: 626.66))
	calfRight2Path.addLine(to: CGPoint(x: 160.03, y: 643.76))
	calfRight2Path.addLine(to: CGPoint(x: 167.87, y: 690.9))
	calfRight2Path.addLine(to: CGPoint(x: 151.69, y: 694.57))
	calfRight2Path.addLine(to: CGPoint(x: 149.24, y: 644.25))
	calfRight2Path.addLine(to: CGPoint(x: 144.83, y: 616.4))
	calfRight2Path.addLine(to: CGPoint(x: 142.38, y: 585.62))
	calfRight2Path.addLine(to: CGPoint(x: 147.28, y: 554.11))
	calfRight2Path.close()
	



	//// CalfRight Drawing
	calfRightPath = UIBezierPath()
	calfRightPath.move(to: CGPoint(x: 184.53, y: 563.39))
	calfRightPath.addLine(to: CGPoint(x: 179.88, y: 572.43))
	calfRightPath.addLine(to: CGPoint(x: 172.77, y: 581.96))
	calfRightPath.addLine(to: CGPoint(x: 169.83, y: 590.51))
	calfRightPath.addLine(to: CGPoint(x: 168.11, y: 604.67))
	calfRightPath.addLine(to: CGPoint(x: 169.09, y: 625.68))
	calfRightPath.addLine(to: CGPoint(x: 171.05, y: 652.31))
	calfRightPath.addLine(to: CGPoint(x: 177.42, y: 674.78))
	calfRightPath.addLine(to: CGPoint(x: 180.61, y: 650.84))
	calfRightPath.addLine(to: CGPoint(x: 181.84, y: 627.39))
	calfRightPath.addLine(to: CGPoint(x: 186.98, y: 616.4))
	calfRightPath.addLine(to: CGPoint(x: 189.43, y: 606.63))
	calfRightPath.addLine(to: CGPoint(x: 188.45, y: 587.09))
	calfRightPath.addLine(to: CGPoint(x: 184.53, y: 563.39))
	calfRightPath.close()
	



	//// CalfLeft Drawing
	calfLeftPath = UIBezierPath()
	calfLeftPath.move(to: CGPoint(x: 229.87, y: 568.52))
	calfLeftPath.addLine(to: CGPoint(x: 238.93, y: 584.15))
	calfLeftPath.addLine(to: CGPoint(x: 242.36, y: 594.66))
	calfLeftPath.addLine(to: CGPoint(x: 243.83, y: 621.28))
	calfLeftPath.addLine(to: CGPoint(x: 243.59, y: 648.15))
	calfLeftPath.addLine(to: CGPoint(x: 243.59, y: 657.44))
	calfLeftPath.addLine(to: CGPoint(x: 240.16, y: 666.47))
	calfLeftPath.addLine(to: CGPoint(x: 236.73, y: 648.15))
	calfLeftPath.addLine(to: CGPoint(x: 235.5, y: 625.93))
	calfLeftPath.addLine(to: CGPoint(x: 228.64, y: 608.09))
	calfLeftPath.addLine(to: CGPoint(x: 228.64, y: 586.84))
	calfLeftPath.addLine(to: CGPoint(x: 229.87, y: 568.52))
	calfLeftPath.close()
	



	//// CalfLeft2 Drawing
	calfLeft2Path = UIBezierPath()
	calfLeft2Path.move(to: CGPoint(x: 261.72, y: 549.96))
	calfLeft2Path.addLine(to: CGPoint(x: 258.54, y: 582.44))
	calfLeft2Path.addLine(to: CGPoint(x: 255.84, y: 597.59))
	calfLeft2Path.addLine(to: CGPoint(x: 255.6, y: 624.22))
	calfLeft2Path.addLine(to: CGPoint(x: 252.41, y: 635.45))
	calfLeft2Path.addLine(to: CGPoint(x: 252.17, y: 650.6))
	calfLeft2Path.addLine(to: CGPoint(x: 246.04, y: 689.68))
	calfLeft2Path.addLine(to: CGPoint(x: 260.74, y: 693.34))
	calfLeft2Path.addLine(to: CGPoint(x: 265.4, y: 690.9))
	calfLeft2Path.addLine(to: CGPoint(x: 269.08, y: 622.51))
	calfLeft2Path.addLine(to: CGPoint(x: 272.02, y: 597.59))
	calfLeft2Path.addLine(to: CGPoint(x: 271.04, y: 572.18))
	calfLeft2Path.addLine(to: CGPoint(x: 268.09, y: 556.31))
	calfLeft2Path.addLine(to: CGPoint(x: 261.72, y: 549.96))
	calfLeft2Path.close()
	



	//// BicepsRight2 Drawing
	bicepsRight2Path = UIBezierPath()
	bicepsRight2Path.move(to: CGPoint(x: 142.75, y: 280.64))
	bicepsRight2Path.addLine(to: CGPoint(x: 147.04, y: 270.87))
	bicepsRight2Path.addLine(to: CGPoint(x: 144.72, y: 245.46))
	



	//// QuadLeft2 Drawing
	quadLeft2Path = UIBezierPath()
	quadLeft2Path.move(to: CGPoint(x: 221.78, y: 378.48))
	quadLeft2Path.addLine(to: CGPoint(x: 228.64, y: 364.31))
	quadLeft2Path.addLine(to: CGPoint(x: 227.91, y: 356.74))
	quadLeft2Path.addLine(to: CGPoint(x: 231.09, y: 351.12))
	quadLeft2Path.addLine(to: CGPoint(x: 256.09, y: 339.64))
	quadLeft2Path.addLine(to: CGPoint(x: 266.38, y: 373.1))
	quadLeft2Path.addLine(to: CGPoint(x: 270.3, y: 396.31))
	quadLeft2Path.addLine(to: CGPoint(x: 273.98, y: 413.9))
	quadLeft2Path.addLine(to: CGPoint(x: 275.45, y: 429.04))
	quadLeft2Path.addLine(to: CGPoint(x: 267.85, y: 414.14))
	quadLeft2Path.addLine(to: CGPoint(x: 245.79, y: 379.21))
	quadLeft2Path.addLine(to: CGPoint(x: 240.89, y: 354.54))
	quadLeft2Path.addLine(to: CGPoint(x: 238.2, y: 389.71))
	quadLeft2Path.addLine(to: CGPoint(x: 232.07, y: 432.95))
	quadLeft2Path.addLine(to: CGPoint(x: 227.66, y: 455.91))
	quadLeft2Path.addLine(to: CGPoint(x: 224.97, y: 517.22))
	quadLeft2Path.addLine(to: CGPoint(x: 229.87, y: 529.68))
	quadLeft2Path.addLine(to: CGPoint(x: 233.05, y: 550.44))
	quadLeft2Path.addLine(to: CGPoint(x: 238.93, y: 562.66))
	quadLeft2Path.addLine(to: CGPoint(x: 245.55, y: 570.23))
	quadLeft2Path.addLine(to: CGPoint(x: 240.89, y: 579.27))
	quadLeft2Path.addLine(to: CGPoint(x: 230.11, y: 564.61))
	quadLeft2Path.addLine(to: CGPoint(x: 229.87, y: 559.48))
	quadLeft2Path.addLine(to: CGPoint(x: 226.19, y: 549.47))
	quadLeft2Path.addLine(to: CGPoint(x: 224.97, y: 532.86))
	quadLeft2Path.addLine(to: CGPoint(x: 221.78, y: 524.55))
	quadLeft2Path.addLine(to: CGPoint(x: 220.55, y: 457.62))
	quadLeft2Path.addLine(to: CGPoint(x: 221.78, y: 437.59))
	quadLeft2Path.addLine(to: CGPoint(x: 225.21, y: 424.4))
	quadLeft2Path.addLine(to: CGPoint(x: 225.46, y: 410.48))
	quadLeft2Path.addLine(to: CGPoint(x: 220.31, y: 395.09))
	quadLeft2Path.addLine(to: CGPoint(x: 221.78, y: 378.48))
	quadLeft2Path.close()
	



	//// QuadRight3 Drawing
	quadRight3Path = UIBezierPath()
	quadRight3Path.move(to: CGPoint(x: 133.07, y: 415.85))
	quadRight3Path.addLine(to: CGPoint(x: 137.48, y: 406.81))
	quadRight3Path.addLine(to: CGPoint(x: 147.28, y: 390.45))
	quadRight3Path.addLine(to: CGPoint(x: 153.16, y: 377.74))
	quadRight3Path.addLine(to: CGPoint(x: 158.31, y: 359.67))
	quadRight3Path.addLine(to: CGPoint(x: 159.29, y: 353.8))
	quadRight3Path.addLine(to: CGPoint(x: 159.78, y: 384.09))
	quadRight3Path.addLine(to: CGPoint(x: 166.15, y: 427.82))
	quadRight3Path.addLine(to: CGPoint(x: 175.95, y: 463.24))
	quadRight3Path.addLine(to: CGPoint(x: 176.69, y: 475.94))
	quadRight3Path.addLine(to: CGPoint(x: 180.37, y: 503.06))
	quadRight3Path.addLine(to: CGPoint(x: 181.35, y: 520.64))
	quadRight3Path.addLine(to: CGPoint(x: 177.92, y: 529.19))
	quadRight3Path.addLine(to: CGPoint(x: 174.24, y: 552.4))
	quadRight3Path.addLine(to: CGPoint(x: 163.95, y: 567.06))
	quadRight3Path.addLine(to: CGPoint(x: 168.85, y: 579.51))
	quadRight3Path.addLine(to: CGPoint(x: 181.59, y: 565.59))
	quadRight3Path.addLine(to: CGPoint(x: 185.76, y: 541.9))
	quadRight3Path.addLine(to: CGPoint(x: 186.25, y: 533.83))
	quadRight3Path.addLine(to: CGPoint(x: 184.78, y: 481.07))
	quadRight3Path.addLine(to: CGPoint(x: 183.31, y: 461.77))
	quadRight3Path.addLine(to: CGPoint(x: 174.24, y: 414.38))
	quadRight3Path.addLine(to: CGPoint(x: 179.63, y: 395.58))
	quadRight3Path.addLine(to: CGPoint(x: 178.65, y: 382.63))
	quadRight3Path.addLine(to: CGPoint(x: 169.83, y: 364.31))
	quadRight3Path.addLine(to: CGPoint(x: 169.34, y: 355.03))
	quadRight3Path.addLine(to: CGPoint(x: 165.17, y: 350.38))
	quadRight3Path.addLine(to: CGPoint(x: 147.53, y: 339.64))
	quadRight3Path.addLine(to: CGPoint(x: 144.34, y: 350.87))
	quadRight3Path.addLine(to: CGPoint(x: 142.63, y: 364.06))
	quadRight3Path.addLine(to: CGPoint(x: 137.97, y: 386.29))
	quadRight3Path.addLine(to: CGPoint(x: 133.07, y: 415.85))
	quadRight3Path.close()
	



	//// QuadLeft3 Drawing
	quadLeft3Path = UIBezierPath()
	quadLeft3Path.move(to: CGPoint(x: 206.59, y: 407.54))
	quadLeft3Path.addLine(to: CGPoint(x: 212.96, y: 395.58))
	quadLeft3Path.addLine(to: CGPoint(x: 222.02, y: 379.21))
	quadLeft3Path.addLine(to: CGPoint(x: 220.06, y: 395.09))
	quadLeft3Path.addLine(to: CGPoint(x: 225.21, y: 410.48))
	quadLeft3Path.addLine(to: CGPoint(x: 224.97, y: 424.4))
	quadLeft3Path.addLine(to: CGPoint(x: 222.02, y: 438.32))
	quadLeft3Path.addLine(to: CGPoint(x: 220.31, y: 460.55))
	quadLeft3Path.addLine(to: CGPoint(x: 221.78, y: 524.31))
	quadLeft3Path.addLine(to: CGPoint(x: 219.33, y: 511.85))
	quadLeft3Path.addLine(to: CGPoint(x: 217.86, y: 500.86))
	quadLeft3Path.addLine(to: CGPoint(x: 214.67, y: 482.78))
	quadLeft3Path.addLine(to: CGPoint(x: 211.24, y: 467.88))
	quadLeft3Path.addLine(to: CGPoint(x: 209.04, y: 439.54))
	quadLeft3Path.addLine(to: CGPoint(x: 208.55, y: 428.55))
	quadLeft3Path.addLine(to: CGPoint(x: 209.53, y: 416.83))
	quadLeft3Path.addLine(to: CGPoint(x: 206.59, y: 407.54))
	quadLeft3Path.close()
	



	//// QuadRight2 Drawing
	quadRight2Path = UIBezierPath()
	quadRight2Path.move(to: CGPoint(x: 200.71, y: 409.74))
	quadRight2Path.addLine(to: CGPoint(x: 197.76, y: 413.41))
	quadRight2Path.addLine(to: CGPoint(x: 197.76, y: 427.33))
	quadRight2Path.addLine(to: CGPoint(x: 199.48, y: 442.72))
	quadRight2Path.addLine(to: CGPoint(x: 198.5, y: 466.41))
	quadRight2Path.addLine(to: CGPoint(x: 193.84, y: 493.53))
	quadRight2Path.addLine(to: CGPoint(x: 191.15, y: 514.78))
	quadRight2Path.addLine(to: CGPoint(x: 186.49, y: 534.81))
	quadRight2Path.addLine(to: CGPoint(x: 184.53, y: 476.92))
	quadRight2Path.addLine(to: CGPoint(x: 183.06, y: 460.31))
	quadRight2Path.addLine(to: CGPoint(x: 177.42, y: 431.73))
	quadRight2Path.addLine(to: CGPoint(x: 174.24, y: 413.9))
	quadRight2Path.addLine(to: CGPoint(x: 179.88, y: 394.84))
	quadRight2Path.addLine(to: CGPoint(x: 178.65, y: 382.87))
	quadRight2Path.addLine(to: CGPoint(x: 189.19, y: 398.75))
	quadRight2Path.addLine(to: CGPoint(x: 200.71, y: 409.74))
	quadRight2Path.close()
	



	//// BicepsRight Drawing
	bicepsRightPath = UIBezierPath()
	bicepsRightPath.move(to: CGPoint(x: 138.71, y: 192.34))
	bicepsRightPath.addLine(to: CGPoint(x: 130.63, y: 200.46))
	bicepsRightPath.addLine(to: CGPoint(x: 123.95, y: 216.02))
	bicepsRightPath.addLine(to: CGPoint(x: 120.57, y: 224.34))
	bicepsRightPath.addLine(to: CGPoint(x: 116.03, y: 236.44))
	bicepsRightPath.addLine(to: CGPoint(x: 113.71, y: 245.84))
	bicepsRightPath.addLine(to: CGPoint(x: 111.75, y: 253.77))
	bicepsRightPath.addLine(to: CGPoint(x: 111.75, y: 264.52))
	bicepsRightPath.addLine(to: CGPoint(x: 111.75, y: 276.61))
	bicepsRightPath.addLine(to: CGPoint(x: 116.06, y: 288.03))
	bicepsRightPath.addLine(to: CGPoint(x: 124.13, y: 281.62))
	bicepsRightPath.addLine(to: CGPoint(x: 131.12, y: 275.87))
	bicepsRightPath.addLine(to: CGPoint(x: 142.66, y: 281.04))
	bicepsRightPath.addLine(to: CGPoint(x: 143.28, y: 273.65))
	bicepsRightPath.addLine(to: CGPoint(x: 144.46, y: 247.18))
	bicepsRightPath.addLine(to: CGPoint(x: 143.48, y: 222.99))
	bicepsRightPath.addLine(to: CGPoint(x: 137.48, y: 205.29))
	bicepsRightPath.addLine(to: CGPoint(x: 138.71, y: 192.34))
	bicepsRightPath.close()
	



	//// QuadRight4 Drawing
	quadRight4Path = UIBezierPath()
	quadRight4Path.move(to: CGPoint(x: 147.53, y: 340.12))
	quadRight4Path.addLine(to: CGPoint(x: 144.34, y: 351.61))
	quadRight4Path.addLine(to: CGPoint(x: 142.38, y: 365.29))
	quadRight4Path.addLine(to: CGPoint(x: 142.63, y: 346.23))
	quadRight4Path.addLine(to: CGPoint(x: 144.83, y: 338.9))
	quadRight4Path.addLine(to: CGPoint(x: 147.53, y: 340.12))
	quadRight4Path.close()
	



	//// QuadLeft4 Drawing
	quadLeft4Path = UIBezierPath()
	quadLeft4Path.move(to: CGPoint(x: 256.82, y: 339.64))
	quadLeft4Path.addLine(to: CGPoint(x: 260.99, y: 334.75))
	quadLeft4Path.addLine(to: CGPoint(x: 264.66, y: 345.01))
	quadLeft4Path.addLine(to: CGPoint(x: 265.89, y: 370.9))
	quadLeft4Path.addLine(to: CGPoint(x: 256.82, y: 339.64))
	quadLeft4Path.close()
	



	//// UpperTrapLeft2 Drawing
	upperTrapLeft2Path = UIBezierPath()
	upperTrapLeft2Path.move(to: CGPoint(x: 517.07, y: 89.5))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 522.95, y: 89.5))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 524.06, y: 95.36))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 523.44, y: 106.11))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 521.24, y: 114.42))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 517.07, y: 120.52))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 516.22, y: 127.72))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 501.14, y: 133.47))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 485.7, y: 139.82))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 471.13, y: 144.71))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 465.97, y: 139.82))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 477.24, y: 135.91))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 489.87, y: 130.29))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 498.81, y: 123.82))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 509.47, y: 116.13))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 515.35, y: 106.23))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 516.71, y: 96.22))
	upperTrapLeft2Path.addLine(to: CGPoint(x: 517.07, y: 89.5))
	upperTrapLeft2Path.close()
	



	//// UpperTrapRight2 Drawing
	upperTrapRight2Path = UIBezierPath()
	upperTrapRight2Path.move(to: CGPoint(x: 532.14, y: 105.02))
	upperTrapRight2Path.addLine(to: CGPoint(x: 533.37, y: 98.29))
	upperTrapRight2Path.addLine(to: CGPoint(x: 535.57, y: 92.8))
	upperTrapRight2Path.addLine(to: CGPoint(x: 540.1, y: 92.92))
	upperTrapRight2Path.addLine(to: CGPoint(x: 540.23, y: 100.74))
	upperTrapRight2Path.addLine(to: CGPoint(x: 539.74, y: 106.72))
	upperTrapRight2Path.addLine(to: CGPoint(x: 543.05, y: 114.42))
	upperTrapRight2Path.addLine(to: CGPoint(x: 547.09, y: 122.23))
	upperTrapRight2Path.addLine(to: CGPoint(x: 555.17, y: 128.7))
	upperTrapRight2Path.addLine(to: CGPoint(x: 566.57, y: 134.82))
	upperTrapRight2Path.addLine(to: CGPoint(x: 576.13, y: 139.94))
	upperTrapRight2Path.addLine(to: CGPoint(x: 584.46, y: 142.51))
	upperTrapRight2Path.addLine(to: CGPoint(x: 580.42, y: 147.39))
	upperTrapRight2Path.addLine(to: CGPoint(x: 575.39, y: 146.42))
	upperTrapRight2Path.addLine(to: CGPoint(x: 566.82, y: 142.51))
	upperTrapRight2Path.addLine(to: CGPoint(x: 558.86, y: 137.75))
	upperTrapRight2Path.addLine(to: CGPoint(x: 548.19, y: 133.35))
	upperTrapRight2Path.addLine(to: CGPoint(x: 539, y: 130.05))
	upperTrapRight2Path.addLine(to: CGPoint(x: 536.55, y: 121.5))
	upperTrapRight2Path.addLine(to: CGPoint(x: 532.14, y: 109.53))
	



	//// QuadLeft Drawing
	quadLeftPath = UIBezierPath()
	quadLeftPath.move(to: CGPoint(x: 240.89, y: 356.74))
	quadLeftPath.addLine(to: CGPoint(x: 245.55, y: 378.96))
	quadLeftPath.addLine(to: CGPoint(x: 254.13, y: 393.13))
	quadLeftPath.addLine(to: CGPoint(x: 268.09, y: 414.87))
	quadLeftPath.addLine(to: CGPoint(x: 275.69, y: 430.26))
	quadLeftPath.addLine(to: CGPoint(x: 279.61, y: 451.51))
	quadLeftPath.addLine(to: CGPoint(x: 278.39, y: 483.27))
	quadLeftPath.addLine(to: CGPoint(x: 274.47, y: 501.83))
	quadLeftPath.addLine(to: CGPoint(x: 269.57, y: 511.85))
	quadLeftPath.addLine(to: CGPoint(x: 267.36, y: 529.93))
	quadLeftPath.addLine(to: CGPoint(x: 263.93, y: 536.28))
	quadLeftPath.addLine(to: CGPoint(x: 258.54, y: 523.57))
	quadLeftPath.addLine(to: CGPoint(x: 256.82, y: 508.92))
	quadLeftPath.addLine(to: CGPoint(x: 245.3, y: 507.94))
	quadLeftPath.addLine(to: CGPoint(x: 245.06, y: 520.15))
	quadLeftPath.addLine(to: CGPoint(x: 242.85, y: 531.15))
	quadLeftPath.addLine(to: CGPoint(x: 237.71, y: 534.32))
	quadLeftPath.addLine(to: CGPoint(x: 230.11, y: 529.93))
	quadLeftPath.addLine(to: CGPoint(x: 225.46, y: 517.71))
	quadLeftPath.addLine(to: CGPoint(x: 225.46, y: 499.15))
	quadLeftPath.addLine(to: CGPoint(x: 227.17, y: 461.04))
	quadLeftPath.addLine(to: CGPoint(x: 232.32, y: 432.7))
	quadLeftPath.addLine(to: CGPoint(x: 238.2, y: 390.93))
	quadLeftPath.addLine(to: CGPoint(x: 240.89, y: 356.74))
	quadLeftPath.close()
	



	//// middleTrapRight Drawing
	middleTrapRightPath = UIBezierPath()
	middleTrapRightPath.move(to: CGPoint(x: 538.76, y: 129.93))
	middleTrapRightPath.addLine(to: CGPoint(x: 545.37, y: 164.62))
	middleTrapRightPath.addLine(to: CGPoint(x: 580.17, y: 147.39))
	middleTrapRightPath.addLine(to: CGPoint(x: 575.52, y: 146.54))
	middleTrapRightPath.addLine(to: CGPoint(x: 566.7, y: 142.51))
	middleTrapRightPath.addLine(to: CGPoint(x: 559.09, y: 137.87))
	middleTrapRightPath.addLine(to: CGPoint(x: 548.07, y: 133.35))
	middleTrapRightPath.addLine(to: CGPoint(x: 538.76, y: 129.93))
	middleTrapRightPath.close()
	



	//// middleTrapLeft Drawing
	middleTrapLeftPath = UIBezierPath()
	middleTrapLeftPath.move(to: CGPoint(x: 471.24, y: 144.59))
	middleTrapLeftPath.addLine(to: CGPoint(x: 485.58, y: 139.82))
	middleTrapLeftPath.addLine(to: CGPoint(x: 501.51, y: 133.47))
	middleTrapLeftPath.addLine(to: CGPoint(x: 516.09, y: 127.72))
	middleTrapLeftPath.addLine(to: CGPoint(x: 518.05, y: 142.02))
	middleTrapLeftPath.addLine(to: CGPoint(x: 521.24, y: 154.97))
	middleTrapLeftPath.addLine(to: CGPoint(x: 523.31, y: 162.05))
	middleTrapLeftPath.addLine(to: CGPoint(x: 478.35, y: 147.75))
	middleTrapLeftPath.addLine(to: CGPoint(x: 471.24, y: 144.59))
	middleTrapLeftPath.close()
	



	//// ForearmRight2 Drawing
	forearmRight2Path = UIBezierPath()
	forearmRight2Path.move(to: CGPoint(x: 616.92, y: 289.92))
	forearmRight2Path.addLine(to: CGPoint(x: 616.43, y: 283.94))
	forearmRight2Path.addLine(to: CGPoint(x: 619.26, y: 280.64))
	forearmRight2Path.addLine(to: CGPoint(x: 625.75, y: 272.82))
	forearmRight2Path.addLine(to: CGPoint(x: 627.96, y: 268.68))
	forearmRight2Path.addLine(to: CGPoint(x: 631.26, y: 283.7))
	forearmRight2Path.addLine(to: CGPoint(x: 632, y: 304.83))
	forearmRight2Path.addLine(to: CGPoint(x: 631.51, y: 337.31))
	forearmRight2Path.addLine(to: CGPoint(x: 631.26, y: 368.34))
	forearmRight2Path.addLine(to: CGPoint(x: 614.11, y: 367.97))
	forearmRight2Path.addLine(to: CGPoint(x: 609.46, y: 366.51))
	forearmRight2Path.addLine(to: CGPoint(x: 602.1, y: 344.64))
	forearmRight2Path.addLine(to: CGPoint(x: 597.08, y: 329.49))
	forearmRight2Path.addLine(to: CGPoint(x: 593.16, y: 312.28))
	forearmRight2Path.addLine(to: CGPoint(x: 591.57, y: 300.06))
	forearmRight2Path.addLine(to: CGPoint(x: 591.69, y: 265.49))
	forearmRight2Path.addLine(to: CGPoint(x: 613.75, y: 290.66))
	forearmRight2Path.addLine(to: CGPoint(x: 616.92, y: 289.92))
	forearmRight2Path.close()
	



	//// ForearmLeft2 Drawing
	forearmLeft2Path = UIBezierPath()
	forearmLeft2Path.move(to: CGPoint(x: 412.92, y: 259.03))
	forearmLeft2Path.addLine(to: CGPoint(x: 406.06, y: 274.05))
	forearmLeft2Path.addLine(to: CGPoint(x: 401.53, y: 287.97))
	forearmLeft2Path.addLine(to: CGPoint(x: 398.95, y: 304.09))
	forearmLeft2Path.addLine(to: CGPoint(x: 397.61, y: 318.26))
	forearmLeft2Path.addLine(to: CGPoint(x: 395.03, y: 336.46))
	forearmLeft2Path.addLine(to: CGPoint(x: 392.71, y: 350.87))
	forearmLeft2Path.addLine(to: CGPoint(x: 390.49, y: 362.35))
	forearmLeft2Path.addLine(to: CGPoint(x: 389.4, y: 370.17))
	forearmLeft2Path.addLine(to: CGPoint(x: 394.05, y: 371.64))
	forearmLeft2Path.addLine(to: CGPoint(x: 409.49, y: 371.88))
	forearmLeft2Path.addLine(to: CGPoint(x: 435.35, y: 329.75))
	forearmLeft2Path.addLine(to: CGPoint(x: 444.29, y: 308.37))
	forearmLeft2Path.addLine(to: CGPoint(x: 448.33, y: 289.56))
	forearmLeft2Path.addLine(to: CGPoint(x: 448.21, y: 280.64))
	forearmLeft2Path.addLine(to: CGPoint(x: 439.14, y: 294.69))
	forearmLeft2Path.addLine(to: CGPoint(x: 424.68, y: 283.94))
	forearmLeft2Path.addLine(to: CGPoint(x: 415.74, y: 268.8))
	forearmLeft2Path.addLine(to: CGPoint(x: 412.92, y: 259.03))
	forearmLeft2Path.close()
	



	//// QuadRight Drawing
	quadRightPath = UIBezierPath()
	quadRightPath.move(to: CGPoint(x: 159.29, y: 356))
	quadRightPath.addLine(to: CGPoint(x: 153.41, y: 377.74))
	quadRightPath.addLine(to: CGPoint(x: 145.32, y: 394.35))
	quadRightPath.addLine(to: CGPoint(x: 137.48, y: 407.54))
	quadRightPath.addLine(to: CGPoint(x: 132.83, y: 418.29))
	quadRightPath.addLine(to: CGPoint(x: 127.92, y: 442.48))
	quadRightPath.addLine(to: CGPoint(x: 126.21, y: 463.73))
	quadRightPath.addLine(to: CGPoint(x: 129.39, y: 491.33))
	quadRightPath.addLine(to: CGPoint(x: 136.01, y: 506.96))
	quadRightPath.addLine(to: CGPoint(x: 140.67, y: 515.27))
	quadRightPath.addLine(to: CGPoint(x: 143.36, y: 530.66))
	quadRightPath.addLine(to: CGPoint(x: 147.28, y: 520.64))
	quadRightPath.addLine(to: CGPoint(x: 147.28, y: 510.87))
	quadRightPath.addLine(to: CGPoint(x: 144.83, y: 505.74))
	quadRightPath.addLine(to: CGPoint(x: 155.62, y: 505.74))
	quadRightPath.addLine(to: CGPoint(x: 158.56, y: 516.98))
	quadRightPath.addLine(to: CGPoint(x: 161.5, y: 528.46))
	quadRightPath.addLine(to: CGPoint(x: 166.15, y: 534.32))
	quadRightPath.addLine(to: CGPoint(x: 171.54, y: 534.32))
	quadRightPath.addLine(to: CGPoint(x: 177.92, y: 529.68))
	quadRightPath.addLine(to: CGPoint(x: 181.35, y: 521.13))
	quadRightPath.addLine(to: CGPoint(x: 180.12, y: 502.32))
	quadRightPath.addLine(to: CGPoint(x: 176.44, y: 474.96))
	quadRightPath.addLine(to: CGPoint(x: 175.95, y: 464.46))
	quadRightPath.addLine(to: CGPoint(x: 166.4, y: 428.06))
	quadRightPath.addLine(to: CGPoint(x: 159.78, y: 385.07))
	quadRightPath.addLine(to: CGPoint(x: 159.29, y: 356))
	quadRightPath.close()
	



	//// SideDeltLeft Drawing
	sideDeltLeftPath = UIBezierPath()
	sideDeltLeftPath.move(to: CGPoint(x: 288.43, y: 214.94))
	sideDeltLeftPath.addLine(to: CGPoint(x: 295.18, y: 226.9))
	sideDeltLeftPath.addLine(to: CGPoint(x: 301.67, y: 205.53))
	sideDeltLeftPath.addLine(to: CGPoint(x: 304.85, y: 186.6))
	sideDeltLeftPath.addLine(to: CGPoint(x: 303.91, y: 177.19))
	sideDeltLeftPath.addLine(to: CGPoint(x: 301.42, y: 169.87))
	sideDeltLeftPath.addLine(to: CGPoint(x: 297.01, y: 163.03))
	sideDeltLeftPath.addLine(to: CGPoint(x: 289.3, y: 156.92))
	sideDeltLeftPath.addLine(to: CGPoint(x: 282.32, y: 153.5))
	sideDeltLeftPath.addLine(to: CGPoint(x: 271.77, y: 150.08))
	sideDeltLeftPath.addLine(to: CGPoint(x: 267.24, y: 150.08))
	sideDeltLeftPath.addLine(to: CGPoint(x: 263.32, y: 153.5))
	sideDeltLeftPath.addLine(to: CGPoint(x: 269.93, y: 153.62))
	sideDeltLeftPath.addLine(to: CGPoint(x: 280.35, y: 159.25))
	sideDeltLeftPath.addLine(to: CGPoint(x: 287.34, y: 164.62))
	sideDeltLeftPath.addLine(to: CGPoint(x: 291.49, y: 177.07))
	sideDeltLeftPath.addLine(to: CGPoint(x: 292.85, y: 190.39))
	sideDeltLeftPath.addLine(to: CGPoint(x: 288.43, y: 214.94))
	sideDeltLeftPath.close()
	



	//// FrontDeltLeft Drawing
	frontDeltLeftPath = UIBezierPath()
	frontDeltLeftPath.move(to: CGPoint(x: 227.66, y: 158.99))
	frontDeltLeftPath.addLine(to: CGPoint(x: 256.33, y: 155.7))
	frontDeltLeftPath.addLine(to: CGPoint(x: 263.56, y: 153.87))
	frontDeltLeftPath.addLine(to: CGPoint(x: 270.18, y: 153.87))
	frontDeltLeftPath.addLine(to: CGPoint(x: 280.35, y: 159.25))
	frontDeltLeftPath.addLine(to: CGPoint(x: 287.26, y: 164.83))
	frontDeltLeftPath.addLine(to: CGPoint(x: 291.26, y: 176.95))
	frontDeltLeftPath.addLine(to: CGPoint(x: 292.73, y: 190.39))
	frontDeltLeftPath.addLine(to: CGPoint(x: 288.55, y: 215.17))
	frontDeltLeftPath.addLine(to: CGPoint(x: 270.42, y: 191.36))
	frontDeltLeftPath.addLine(to: CGPoint(x: 269.2, y: 182.7))
	frontDeltLeftPath.addLine(to: CGPoint(x: 246.78, y: 161.32))
	frontDeltLeftPath.addLine(to: CGPoint(x: 227.66, y: 158.99))
	frontDeltLeftPath.close()
	



	//// UpperChestLeft Drawing
	upperChestLeftPath = UIBezierPath()
	upperChestLeftPath.move(to: CGPoint(x: 205.72, y: 163.15))
	upperChestLeftPath.addLine(to: CGPoint(x: 227.42, y: 158.99))
	upperChestLeftPath.addLine(to: CGPoint(x: 247.15, y: 161.56))
	upperChestLeftPath.addLine(to: CGPoint(x: 269.08, y: 182.7))
	upperChestLeftPath.addLine(to: CGPoint(x: 270.3, y: 191.36))
	upperChestLeftPath.addLine(to: CGPoint(x: 244.7, y: 172.31))
	upperChestLeftPath.addLine(to: CGPoint(x: 227.66, y: 169.74))
	upperChestLeftPath.addLine(to: CGPoint(x: 205.72, y: 163.15))
	upperChestLeftPath.close()
	



	//// RearDeltLeft Drawing
	rearDeltLeftPath = UIBezierPath()
	rearDeltLeftPath.move(to: CGPoint(x: 421.5, y: 198.82))
	rearDeltLeftPath.addLine(to: CGPoint(x: 426.4, y: 180.98))
	rearDeltLeftPath.addLine(to: CGPoint(x: 432.28, y: 169.02))
	rearDeltLeftPath.addLine(to: CGPoint(x: 443.19, y: 159.73))
	rearDeltLeftPath.addLine(to: CGPoint(x: 461.2, y: 150.45))
	rearDeltLeftPath.addLine(to: CGPoint(x: 470.02, y: 162.29))
	rearDeltLeftPath.addLine(to: CGPoint(x: 458.75, y: 165.71))
	rearDeltLeftPath.addLine(to: CGPoint(x: 450.05, y: 169.99))
	rearDeltLeftPath.addLine(to: CGPoint(x: 443.19, y: 176.71))
	rearDeltLeftPath.addLine(to: CGPoint(x: 440.61, y: 186.6))
	rearDeltLeftPath.addLine(to: CGPoint(x: 434.98, y: 192.83))
	rearDeltLeftPath.addLine(to: CGPoint(x: 426.04, y: 204.68))
	rearDeltLeftPath.addLine(to: CGPoint(x: 424.44, y: 209.19))
	rearDeltLeftPath.addLine(to: CGPoint(x: 421.5, y: 198.82))
	rearDeltLeftPath.close()
	



	//// SideDeltLeft2 Drawing
	sideDeltLeft2Path = UIBezierPath()
	sideDeltLeft2Path.move(to: CGPoint(x: 452.74, y: 142.63))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 442.08, y: 147.27))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 435.35, y: 151.3))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 429.34, y: 158.39))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 423.82, y: 167.3))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 420.65, y: 175.6))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 420.16, y: 184.65))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 421.5, y: 198.69))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 426.15, y: 181.46))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 432.41, y: 169.02))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 443.55, y: 159.48))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 453.6, y: 154.48))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 461.2, y: 150.45))
	sideDeltLeft2Path.addLine(to: CGPoint(x: 452.74, y: 142.63))
	sideDeltLeft2Path.close()
	



	//// LatsRight Drawing
	latsRightPath = UIBezierPath()
	latsRightPath.move(to: CGPoint(x: 587.28, y: 210.42))
	latsRightPath.addLine(to: CGPoint(x: 593.16, y: 199.54))
	latsRightPath.addLine(to: CGPoint(x: 596.96, y: 185.01))
	latsRightPath.addLine(to: CGPoint(x: 597.69, y: 181.23))
	latsRightPath.addLine(to: CGPoint(x: 601.5, y: 179.28))
	latsRightPath.addLine(to: CGPoint(x: 607, y: 180))
	latsRightPath.addLine(to: CGPoint(x: 614.11, y: 186.6))
	latsRightPath.addLine(to: CGPoint(x: 599.9, y: 189.05))
	latsRightPath.addLine(to: CGPoint(x: 597.57, y: 209.8))
	latsRightPath.addLine(to: CGPoint(x: 594.26, y: 218.36))
	latsRightPath.addLine(to: CGPoint(x: 594.63, y: 225.69))
	latsRightPath.addLine(to: CGPoint(x: 591.2, y: 237.53))
	latsRightPath.addLine(to: CGPoint(x: 586.79, y: 247.55))
	latsRightPath.addLine(to: CGPoint(x: 583.23, y: 253.41))
	latsRightPath.addLine(to: CGPoint(x: 581.64, y: 259.03))
	latsRightPath.addLine(to: CGPoint(x: 571.72, y: 278.32))
	latsRightPath.addLine(to: CGPoint(x: 570, y: 288.46))
	latsRightPath.addLine(to: CGPoint(x: 569.51, y: 294.45))
	latsRightPath.addLine(to: CGPoint(x: 567.55, y: 307.15))
	latsRightPath.addLine(to: CGPoint(x: 561.18, y: 319))
	latsRightPath.addLine(to: CGPoint(x: 559.09, y: 324.49))
	latsRightPath.addLine(to: CGPoint(x: 558.11, y: 332.68))
	latsRightPath.addLine(to: CGPoint(x: 551.87, y: 330.24))
	latsRightPath.addLine(to: CGPoint(x: 548.8, y: 322.78))
	latsRightPath.addLine(to: CGPoint(x: 550.89, y: 314.11))
	latsRightPath.addLine(to: CGPoint(x: 552.6, y: 305.81))
	latsRightPath.addLine(to: CGPoint(x: 550.64, y: 295.67))
	latsRightPath.addLine(to: CGPoint(x: 548.19, y: 287.61))
	latsRightPath.addLine(to: CGPoint(x: 543.29, y: 280.77))
	latsRightPath.addLine(to: CGPoint(x: 538.02, y: 275.52))
	latsRightPath.addLine(to: CGPoint(x: 539.37, y: 264.64))
	latsRightPath.addLine(to: CGPoint(x: 544.88, y: 254.14))
	latsRightPath.addLine(to: CGPoint(x: 552.36, y: 241.44))
	latsRightPath.addLine(to: CGPoint(x: 560.93, y: 222.14))
	latsRightPath.addLine(to: CGPoint(x: 563.01, y: 219.08))
	latsRightPath.addLine(to: CGPoint(x: 572.94, y: 219.57))
	



	//// LatsLeft Drawing
	latsLeftPath = UIBezierPath()
	latsLeftPath.move(to: CGPoint(x: 474.3, y: 207.12))
	latsLeftPath.addLine(to: CGPoint(x: 479.46, y: 213.1))
	latsLeftPath.addLine(to: CGPoint(x: 493.3, y: 219.7))
	latsLeftPath.addLine(to: CGPoint(x: 504.08, y: 219.45))
	latsLeftPath.addLine(to: CGPoint(x: 506.16, y: 226.66))
	latsLeftPath.addLine(to: CGPoint(x: 508.49, y: 234.6))
	latsLeftPath.addLine(to: CGPoint(x: 512.9, y: 247.18))
	latsLeftPath.addLine(to: CGPoint(x: 515.84, y: 254.87))
	latsLeftPath.addLine(to: CGPoint(x: 517.43, y: 264.77))
	latsLeftPath.addLine(to: CGPoint(x: 517.43, y: 274.05))
	latsLeftPath.addLine(to: CGPoint(x: 510.08, y: 280.77))
	latsLeftPath.addLine(to: CGPoint(x: 499.92, y: 291.27))
	latsLeftPath.addLine(to: CGPoint(x: 491.71, y: 298.72))
	latsLeftPath.addLine(to: CGPoint(x: 486.68, y: 309.1))
	latsLeftPath.addLine(to: CGPoint(x: 488.52, y: 321.56))
	latsLeftPath.addLine(to: CGPoint(x: 489.5, y: 327.67))
	latsLeftPath.addLine(to: CGPoint(x: 485.7, y: 330.47))
	latsLeftPath.addLine(to: CGPoint(x: 477.01, y: 333.04))
	latsLeftPath.addLine(to: CGPoint(x: 478.11, y: 329.98))
	latsLeftPath.addLine(to: CGPoint(x: 476.88, y: 324.25))
	latsLeftPath.addLine(to: CGPoint(x: 469.17, y: 308.49))
	latsLeftPath.addLine(to: CGPoint(x: 464.38, y: 295.18))
	latsLeftPath.addLine(to: CGPoint(x: 458.99, y: 277.47))
	latsLeftPath.addLine(to: CGPoint(x: 457.89, y: 268.68))
	latsLeftPath.addLine(to: CGPoint(x: 454.46, y: 257.56))
	latsLeftPath.addLine(to: CGPoint(x: 459.73, y: 242.66))
	latsLeftPath.addLine(to: CGPoint(x: 461.44, y: 218.59))
	latsLeftPath.addLine(to: CGPoint(x: 460.34, y: 209.93))
	latsLeftPath.addLine(to: CGPoint(x: 457.15, y: 200.64))
	latsLeftPath.addLine(to: CGPoint(x: 456.05, y: 186.84))
	latsLeftPath.addLine(to: CGPoint(x: 447.11, y: 184.65))
	latsLeftPath.addLine(to: CGPoint(x: 441.59, y: 186.12))
	latsLeftPath.addLine(to: CGPoint(x: 449.31, y: 179.39))
	latsLeftPath.addLine(to: CGPoint(x: 457.52, y: 178.53))
	latsLeftPath.addLine(to: CGPoint(x: 461.56, y: 182.08))
	latsLeftPath.addLine(to: CGPoint(x: 469.04, y: 193.93))
	



	//// TricepsLeft Drawing
	tricepsLeftPath = UIBezierPath()
	tricepsLeftPath.move(to: CGPoint(x: 412.92, y: 258.78))
	tricepsLeftPath.addLine(to: CGPoint(x: 416.23, y: 235.95))
	tricepsLeftPath.addLine(to: CGPoint(x: 420.03, y: 222.14))
	tricepsLeftPath.addLine(to: CGPoint(x: 424.08, y: 214.08))
	tricepsLeftPath.addLine(to: CGPoint(x: 424.31, y: 209.08))
	tricepsLeftPath.addLine(to: CGPoint(x: 426.04, y: 204.55))
	tricepsLeftPath.addLine(to: CGPoint(x: 434.98, y: 192.7))
	tricepsLeftPath.addLine(to: CGPoint(x: 440.61, y: 186.48))
	tricepsLeftPath.addLine(to: CGPoint(x: 447.11, y: 185.01))
	tricepsLeftPath.addLine(to: CGPoint(x: 455.93, y: 186.84))
	tricepsLeftPath.addLine(to: CGPoint(x: 457.28, y: 200.89))
	tricepsLeftPath.addLine(to: CGPoint(x: 460.46, y: 210.05))
	tricepsLeftPath.addLine(to: CGPoint(x: 461.32, y: 218.11))
	tricepsLeftPath.addLine(to: CGPoint(x: 459.48, y: 233.99))
	tricepsLeftPath.addLine(to: CGPoint(x: 459.48, y: 242.3))
	tricepsLeftPath.addLine(to: CGPoint(x: 455.56, y: 254.26))
	tricepsLeftPath.addLine(to: CGPoint(x: 452.99, y: 260.86))
	tricepsLeftPath.addLine(to: CGPoint(x: 450.17, y: 269.77))
	tricepsLeftPath.addLine(to: CGPoint(x: 447.84, y: 274.66))
	tricepsLeftPath.addLine(to: CGPoint(x: 448.09, y: 280.64))
	tricepsLeftPath.addLine(to: CGPoint(x: 439.14, y: 294.32))
	tricepsLeftPath.addLine(to: CGPoint(x: 424.68, y: 284.06))
	tricepsLeftPath.addLine(to: CGPoint(x: 415.98, y: 269.4))
	tricepsLeftPath.addLine(to: CGPoint(x: 412.92, y: 258.78))
	tricepsLeftPath.close()
	



	//// TricepsRight Drawing
	tricepsRightPath = UIBezierPath()
	tricepsRightPath.move(to: CGPoint(x: 586.91, y: 247.79))
	tricepsRightPath.addLine(to: CGPoint(x: 591.32, y: 237.53))
	tricepsRightPath.addLine(to: CGPoint(x: 594.51, y: 225.8))
	tricepsRightPath.addLine(to: CGPoint(x: 594.26, y: 218.85))
	tricepsRightPath.addLine(to: CGPoint(x: 597.57, y: 210.17))
	tricepsRightPath.addLine(to: CGPoint(x: 600.03, y: 189.05))
	tricepsRightPath.addLine(to: CGPoint(x: 610.06, y: 187.58))
	tricepsRightPath.addLine(to: CGPoint(x: 614.11, y: 186.84))
	tricepsRightPath.addLine(to: CGPoint(x: 617.54, y: 197.96))
	tricepsRightPath.addLine(to: CGPoint(x: 617.67, y: 201.98))
	tricepsRightPath.addLine(to: CGPoint(x: 620.61, y: 209.8))
	tricepsRightPath.addLine(to: CGPoint(x: 625.38, y: 222.14))
	tricepsRightPath.addLine(to: CGPoint(x: 625.63, y: 229.6))
	tricepsRightPath.addLine(to: CGPoint(x: 626.49, y: 247.18))
	tricepsRightPath.addLine(to: CGPoint(x: 627.59, y: 252.67))
	tricepsRightPath.addLine(to: CGPoint(x: 627.96, y: 268.55))
	tricepsRightPath.addLine(to: CGPoint(x: 625.63, y: 272.71))
	tricepsRightPath.addLine(to: CGPoint(x: 616.43, y: 283.82))
	tricepsRightPath.addLine(to: CGPoint(x: 616.81, y: 289.8))
	tricepsRightPath.addLine(to: CGPoint(x: 613.98, y: 290.54))
	tricepsRightPath.addLine(to: CGPoint(x: 590.83, y: 264.28))
	tricepsRightPath.addLine(to: CGPoint(x: 588.14, y: 255.36))
	tricepsRightPath.addLine(to: CGPoint(x: 586.91, y: 247.79))
	tricepsRightPath.close()
	



	//// RearDeltRight Drawing
	rearDeltRightPath = UIBezierPath()
	rearDeltRightPath.move(to: CGPoint(x: 596.1, y: 154.11))
	rearDeltRightPath.addLine(to: CGPoint(x: 601.86, y: 156.55))
	rearDeltRightPath.addLine(to: CGPoint(x: 609.34, y: 162.41))
	rearDeltRightPath.addLine(to: CGPoint(x: 615.22, y: 171.33))
	rearDeltRightPath.addLine(to: CGPoint(x: 620.73, y: 186.97))
	rearDeltRightPath.addLine(to: CGPoint(x: 617.67, y: 197.71))
	rearDeltRightPath.addLine(to: CGPoint(x: 614.47, y: 187.33))
	rearDeltRightPath.addLine(to: CGPoint(x: 614.11, y: 184.4))
	rearDeltRightPath.addLine(to: CGPoint(x: 610.68, y: 177.68))
	rearDeltRightPath.addLine(to: CGPoint(x: 604.8, y: 170.97))
	rearDeltRightPath.addLine(to: CGPoint(x: 594.14, y: 163.76))
	rearDeltRightPath.addLine(to: CGPoint(x: 596.1, y: 154.11))
	rearDeltRightPath.close()
	



	//// SideDeltRight2 Drawing
	sideDeltRight2Path = UIBezierPath()
	sideDeltRight2Path.move(to: CGPoint(x: 597.94, y: 147.52))
	sideDeltRight2Path.addLine(to: CGPoint(x: 607.74, y: 152.03))
	sideDeltRight2Path.addLine(to: CGPoint(x: 614.36, y: 158.76))
	sideDeltRight2Path.addLine(to: CGPoint(x: 618.88, y: 166.2))
	sideDeltRight2Path.addLine(to: CGPoint(x: 620.36, y: 173.77))
	sideDeltRight2Path.addLine(to: CGPoint(x: 620.61, y: 187.33))
	sideDeltRight2Path.addLine(to: CGPoint(x: 615.34, y: 171.2))
	sideDeltRight2Path.addLine(to: CGPoint(x: 609.7, y: 162.78))
	sideDeltRight2Path.addLine(to: CGPoint(x: 601.61, y: 156.43))
	sideDeltRight2Path.addLine(to: CGPoint(x: 596.1, y: 154.11))
	sideDeltRight2Path.addLine(to: CGPoint(x: 597.94, y: 147.52))
	sideDeltRight2Path.close()
	



	//// RotatorCuffRight Drawing
	rotatorCuffRightPath = UIBezierPath()
	rotatorCuffRightPath.move(to: CGPoint(x: 562.65, y: 218.97))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 566.82, y: 210.66))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 566.93, y: 196.37))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 571.23, y: 180.74))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 571.83, y: 165.83))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 574.41, y: 163.27))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 576.86, y: 166.45))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 594.63, y: 167.42))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 604.8, y: 170.84))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 610.81, y: 178.04))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 614.11, y: 184.28))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 614.36, y: 186.97))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 607, y: 179.76))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 601.5, y: 179.15))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 597.81, y: 181.23))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 595.61, y: 189.28))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 591.69, y: 202.35))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 587.28, y: 210.78))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 580.91, y: 215.66))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 572.94, y: 219.7))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 568.29, y: 219.45))
	rotatorCuffRightPath.addLine(to: CGPoint(x: 562.65, y: 218.97))
	rotatorCuffRightPath.close()
	



	//// RotatorCuffLeft Drawing
	rotatorCuffLeftPath = UIBezierPath()
	rotatorCuffLeftPath.move(to: CGPoint(x: 440.86, y: 186.48))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 443.31, y: 176.95))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 450.17, y: 170.11))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 458.99, y: 165.96))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 486.68, y: 165.47))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 491.34, y: 163.03))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 495.75, y: 167.18))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 501.39, y: 193.32))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 502.86, y: 214.08))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 504.2, y: 219.34))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 493.3, y: 219.7))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 479.69, y: 213.35))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 474.56, y: 207.12))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 469.17, y: 193.8))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 461.32, y: 181.84))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 457.52, y: 178.53))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 449.31, y: 179.39))
	rotatorCuffLeftPath.addLine(to: CGPoint(x: 440.86, y: 186.48))
	rotatorCuffLeftPath.close()
	



	//// HamstringLeft3 Drawing
	hamstringLeft3Path = UIBezierPath()
	hamstringLeft3Path.move(to: CGPoint(x: 453.11, y: 404.61))
	hamstringLeft3Path.addLine(to: CGPoint(x: 449.19, y: 425.62))
	hamstringLeft3Path.addLine(to: CGPoint(x: 443.55, y: 445.9))
	hamstringLeft3Path.addLine(to: CGPoint(x: 443.55, y: 466.17))
	hamstringLeft3Path.addLine(to: CGPoint(x: 446, y: 484.73))
	hamstringLeft3Path.addLine(to: CGPoint(x: 448.45, y: 503.3))
	hamstringLeft3Path.addLine(to: CGPoint(x: 449.92, y: 525.53))
	hamstringLeft3Path.addLine(to: CGPoint(x: 451.4, y: 507.7))
	hamstringLeft3Path.addLine(to: CGPoint(x: 453.6, y: 474.23))
	hamstringLeft3Path.addLine(to: CGPoint(x: 455.07, y: 453.47))
	hamstringLeft3Path.addLine(to: CGPoint(x: 456.54, y: 434.17))
	hamstringLeft3Path.addLine(to: CGPoint(x: 457.52, y: 420.49))
	hamstringLeft3Path.addLine(to: CGPoint(x: 453.11, y: 404.61))
	hamstringLeft3Path.close()
	



	//// Glute Drawing
	glutePath = UIBezierPath()
	glutePath.move(to: CGPoint(x: 462.42, y: 332.8))
	glutePath.addLine(to: CGPoint(x: 471, y: 334.51))
	glutePath.addLine(to: CGPoint(x: 478.84, y: 338.66))
	glutePath.addLine(to: CGPoint(x: 490.11, y: 348.19))
	glutePath.addLine(to: CGPoint(x: 498.69, y: 355.51))
	glutePath.addLine(to: CGPoint(x: 504.57, y: 362.6))
	glutePath.addLine(to: CGPoint(x: 511.43, y: 371.39))
	glutePath.addLine(to: CGPoint(x: 523.69, y: 371.64))
	glutePath.addLine(to: CGPoint(x: 531.53, y: 359.91))
	glutePath.addLine(to: CGPoint(x: 539.37, y: 352.09))
	glutePath.addLine(to: CGPoint(x: 561.67, y: 334.51))
	glutePath.addLine(to: CGPoint(x: 568.78, y: 332.31))
	glutePath.addLine(to: CGPoint(x: 570.74, y: 345.99))
	glutePath.addLine(to: CGPoint(x: 571.72, y: 360.16))
	glutePath.addLine(to: CGPoint(x: 570.49, y: 376.52))
	glutePath.addLine(to: CGPoint(x: 571.47, y: 388.98))
	glutePath.addLine(to: CGPoint(x: 571.47, y: 405.83))
	glutePath.addLine(to: CGPoint(x: 566.33, y: 415.12))
	glutePath.addLine(to: CGPoint(x: 557.01, y: 421.71))
	glutePath.addLine(to: CGPoint(x: 549.17, y: 423.42))
	glutePath.addLine(to: CGPoint(x: 536.43, y: 422.45))
	glutePath.addLine(to: CGPoint(x: 520.26, y: 415.36))
	glutePath.addLine(to: CGPoint(x: 517.31, y: 409.74))
	glutePath.addLine(to: CGPoint(x: 513.39, y: 409.74))
	glutePath.addLine(to: CGPoint(x: 506.53, y: 417.56))
	glutePath.addLine(to: CGPoint(x: 496.49, y: 423.18))
	glutePath.addLine(to: CGPoint(x: 483.01, y: 424.16))
	glutePath.addLine(to: CGPoint(x: 476.39, y: 420))
	glutePath.addLine(to: CGPoint(x: 465.85, y: 414.87))
	glutePath.addLine(to: CGPoint(x: 462.67, y: 405.83))
	glutePath.addLine(to: CGPoint(x: 459.97, y: 394.84))
	glutePath.addLine(to: CGPoint(x: 462.67, y: 376.03))
	glutePath.addLine(to: CGPoint(x: 461.69, y: 350.14))
	glutePath.addLine(to: CGPoint(x: 462.42, y: 332.8))
	glutePath.close()
	



	//// HamstringRight3 Drawing
	hamstringRight3Path = UIBezierPath()
	hamstringRight3Path.move(to: CGPoint(x: 549.42, y: 423.67))
	hamstringRight3Path.addLine(to: CGPoint(x: 535.94, y: 422.45))
	hamstringRight3Path.addLine(to: CGPoint(x: 520.01, y: 415.36))
	hamstringRight3Path.addLine(to: CGPoint(x: 518.79, y: 441.01))
	hamstringRight3Path.addLine(to: CGPoint(x: 521.97, y: 472.77))
	hamstringRight3Path.addLine(to: CGPoint(x: 526.87, y: 501.83))
	hamstringRight3Path.addLine(to: CGPoint(x: 534.22, y: 533.35))
	hamstringRight3Path.addLine(to: CGPoint(x: 538.39, y: 540.67))
	hamstringRight3Path.addLine(to: CGPoint(x: 536.43, y: 523.09))
	hamstringRight3Path.addLine(to: CGPoint(x: 535.2, y: 491.33))
	hamstringRight3Path.addLine(to: CGPoint(x: 537.16, y: 478.14))
	hamstringRight3Path.addLine(to: CGPoint(x: 541.82, y: 462.51))
	hamstringRight3Path.addLine(to: CGPoint(x: 543.54, y: 441.5))
	hamstringRight3Path.addLine(to: CGPoint(x: 549.42, y: 423.67))
	hamstringRight3Path.close()
	



	//// HamstringLeft2 Drawing
	hamstringLeft2Path = UIBezierPath()
	hamstringLeft2Path.move(to: CGPoint(x: 486.93, y: 423.67))
	hamstringLeft2Path.addLine(to: CGPoint(x: 496.49, y: 423.42))
	hamstringLeft2Path.addLine(to: CGPoint(x: 506.78, y: 417.8))
	hamstringLeft2Path.addLine(to: CGPoint(x: 508.25, y: 432.46))
	hamstringLeft2Path.addLine(to: CGPoint(x: 508.98, y: 457.38))
	hamstringLeft2Path.addLine(to: CGPoint(x: 505.8, y: 481.07))
	hamstringLeft2Path.addLine(to: CGPoint(x: 502.12, y: 496.95))
	hamstringLeft2Path.addLine(to: CGPoint(x: 501.39, y: 509.65))
	hamstringLeft2Path.addLine(to: CGPoint(x: 496.24, y: 534.32))
	hamstringLeft2Path.addLine(to: CGPoint(x: 496.49, y: 484.49))
	hamstringLeft2Path.addLine(to: CGPoint(x: 491.58, y: 468.86))
	hamstringLeft2Path.addLine(to: CGPoint(x: 486.93, y: 423.67))
	hamstringLeft2Path.close()
	



	//// HamstringRight Drawing
	hamstringRightPath = UIBezierPath()
	hamstringRightPath.move(to: CGPoint(x: 575.15, y: 441.5))
	hamstringRightPath.addLine(to: CGPoint(x: 570.49, y: 431.24))
	hamstringRightPath.addLine(to: CGPoint(x: 565.35, y: 424.64))
	hamstringRightPath.addLine(to: CGPoint(x: 549.17, y: 424.16))
	hamstringRightPath.addLine(to: CGPoint(x: 544.03, y: 441.74))
	hamstringRightPath.addLine(to: CGPoint(x: 542.07, y: 461.53))
	hamstringRightPath.addLine(to: CGPoint(x: 537.16, y: 478.38))
	hamstringRightPath.addLine(to: CGPoint(x: 535.2, y: 491.82))
	hamstringRightPath.addLine(to: CGPoint(x: 537.41, y: 532.12))
	hamstringRightPath.addLine(to: CGPoint(x: 538.63, y: 539.21))
	hamstringRightPath.addLine(to: CGPoint(x: 538.14, y: 556.8))
	hamstringRightPath.addLine(to: CGPoint(x: 539.12, y: 565.1))
	hamstringRightPath.addLine(to: CGPoint(x: 546.23, y: 552.89))
	hamstringRightPath.addLine(to: CGPoint(x: 553.58, y: 545.31))
	hamstringRightPath.addLine(to: CGPoint(x: 557.99, y: 553.62))
	hamstringRightPath.addLine(to: CGPoint(x: 565.35, y: 548))
	hamstringRightPath.addLine(to: CGPoint(x: 569.51, y: 538.96))
	hamstringRightPath.addLine(to: CGPoint(x: 577.6, y: 554.11))
	hamstringRightPath.addLine(to: CGPoint(x: 579.56, y: 517.22))
	hamstringRightPath.addLine(to: CGPoint(x: 576.62, y: 487.91))
	hamstringRightPath.addLine(to: CGPoint(x: 577.6, y: 467.64))
	hamstringRightPath.addLine(to: CGPoint(x: 575.15, y: 441.5))
	hamstringRightPath.close()
	



	//// HamstringLeft Drawing
	hamstringLeftPath = UIBezierPath()
	hamstringLeftPath.move(to: CGPoint(x: 455.81, y: 443.45))
	hamstringLeftPath.addLine(to: CGPoint(x: 461.69, y: 432.95))
	hamstringLeftPath.addLine(to: CGPoint(x: 467.81, y: 425.38))
	hamstringLeftPath.addLine(to: CGPoint(x: 486.44, y: 423.91))
	hamstringLeftPath.addLine(to: CGPoint(x: 491.58, y: 469.35))
	hamstringLeftPath.addLine(to: CGPoint(x: 496.24, y: 484.25))
	hamstringLeftPath.addLine(to: CGPoint(x: 496, y: 531.88))
	hamstringLeftPath.addLine(to: CGPoint(x: 494.03, y: 546.54))
	hamstringLeftPath.addLine(to: CGPoint(x: 492.56, y: 556.31))
	hamstringLeftPath.addLine(to: CGPoint(x: 490.36, y: 562.9))
	hamstringLeftPath.addLine(to: CGPoint(x: 484.48, y: 551.67))
	hamstringLeftPath.addLine(to: CGPoint(x: 477.37, y: 544.09))
	hamstringLeftPath.addLine(to: CGPoint(x: 474.92, y: 548.98))
	hamstringLeftPath.addLine(to: CGPoint(x: 474.68, y: 554.6))
	hamstringLeftPath.addLine(to: CGPoint(x: 467.08, y: 549.22))
	hamstringLeftPath.addLine(to: CGPoint(x: 460.71, y: 538.96))
	hamstringLeftPath.addLine(to: CGPoint(x: 456.05, y: 550.44))
	hamstringLeftPath.addLine(to: CGPoint(x: 450.91, y: 556.31))
	hamstringLeftPath.addLine(to: CGPoint(x: 450.17, y: 525.28))
	hamstringLeftPath.addLine(to: CGPoint(x: 452.87, y: 489.13))
	hamstringLeftPath.addLine(to: CGPoint(x: 455.81, y: 443.45))
	hamstringLeftPath.close()
	



	//// HamstringRight2 Drawing
	hamstringRight2Path = UIBezierPath()
	hamstringRight2Path.move(to: CGPoint(x: 577.84, y: 402.41))
	hamstringRight2Path.addLine(to: CGPoint(x: 581.03, y: 424.89))
	hamstringRight2Path.addLine(to: CGPoint(x: 585.44, y: 439.54))
	hamstringRight2Path.addLine(to: CGPoint(x: 586.42, y: 462.75))
	hamstringRight2Path.addLine(to: CGPoint(x: 584.21, y: 480.58))
	hamstringRight2Path.addLine(to: CGPoint(x: 582.5, y: 499.15))
	hamstringRight2Path.addLine(to: CGPoint(x: 579.31, y: 517.22))
	hamstringRight2Path.addLine(to: CGPoint(x: 577.35, y: 490.35))
	hamstringRight2Path.addLine(to: CGPoint(x: 577.6, y: 466.66))
	hamstringRight2Path.addLine(to: CGPoint(x: 575.64, y: 442.23))
	hamstringRight2Path.addLine(to: CGPoint(x: 575.64, y: 416.58))
	hamstringRight2Path.addLine(to: CGPoint(x: 577.84, y: 402.41))
	hamstringRight2Path.close()
	



	//// CoreRight2 Drawing
	coreRight2Path = UIBezierPath()
	coreRight2Path.move(to: CGPoint(x: 558.24, y: 332.91))
	coreRight2Path.addLine(to: CGPoint(x: 558.73, y: 325.84))
	coreRight2Path.addLine(to: CGPoint(x: 560.69, y: 319.98))
	coreRight2Path.addLine(to: CGPoint(x: 567.42, y: 307.88))
	coreRight2Path.addLine(to: CGPoint(x: 569.64, y: 294.69))
	coreRight2Path.addLine(to: CGPoint(x: 571.23, y: 304.34))
	coreRight2Path.addLine(to: CGPoint(x: 572.7, y: 310.44))
	coreRight2Path.addLine(to: CGPoint(x: 572.32, y: 319.23))
	coreRight2Path.addLine(to: CGPoint(x: 570.49, y: 328.52))
	coreRight2Path.addLine(to: CGPoint(x: 558.24, y: 332.91))
	coreRight2Path.close()
	



	//// CoreLeft3 Drawing
	coreLeft3Path = UIBezierPath()
	coreLeft3Path.move(to: CGPoint(x: 459.11, y: 278.32))
	coreLeft3Path.addLine(to: CGPoint(x: 464.14, y: 295.18))
	coreLeft3Path.addLine(to: CGPoint(x: 469.53, y: 309.35))
	coreLeft3Path.addLine(to: CGPoint(x: 476.88, y: 324))
	coreLeft3Path.addLine(to: CGPoint(x: 478.11, y: 329.87))
	coreLeft3Path.addLine(to: CGPoint(x: 476.88, y: 333.53))
	coreLeft3Path.addLine(to: CGPoint(x: 466.83, y: 329.87))
	coreLeft3Path.addLine(to: CGPoint(x: 458.26, y: 328.89))
	coreLeft3Path.addLine(to: CGPoint(x: 455.93, y: 320.83))
	coreLeft3Path.addLine(to: CGPoint(x: 455.93, y: 305.32))
	coreLeft3Path.addLine(to: CGPoint(x: 458.38, y: 296.89))
	coreLeft3Path.addLine(to: CGPoint(x: 459.11, y: 278.32))
	coreLeft3Path.close()
	



	//// LowerChestLeft Drawing
	lowerChestLeftPath = UIBezierPath()
	lowerChestLeftPath.move(to: CGPoint(x: 205.72, y: 163.03))
	lowerChestLeftPath.addLine(to: CGPoint(x: 227.17, y: 169.62))
	lowerChestLeftPath.addLine(to: CGPoint(x: 244.44, y: 172.31))
	lowerChestLeftPath.addLine(to: CGPoint(x: 262.34, y: 185.74))
	lowerChestLeftPath.addLine(to: CGPoint(x: 262.34, y: 201.13))
	lowerChestLeftPath.addLine(to: CGPoint(x: 260.99, y: 205.29))
	lowerChestLeftPath.addLine(to: CGPoint(x: 254.37, y: 216.28))
	lowerChestLeftPath.addLine(to: CGPoint(x: 244.34, y: 226.07))
	lowerChestLeftPath.addLine(to: CGPoint(x: 224.84, y: 229.71))
	lowerChestLeftPath.addLine(to: CGPoint(x: 217.49, y: 229.71))
	lowerChestLeftPath.addLine(to: CGPoint(x: 200.1, y: 224.22))
	lowerChestLeftPath.addLine(to: CGPoint(x: 194.24, y: 221.15))
	lowerChestLeftPath.addLine(to: CGPoint(x: 190.35, y: 212.26))
	lowerChestLeftPath.addLine(to: CGPoint(x: 191.64, y: 195.76))
	lowerChestLeftPath.addLine(to: CGPoint(x: 197.76, y: 175.37))
	lowerChestLeftPath.addLine(to: CGPoint(x: 205.72, y: 163.03))
	lowerChestLeftPath.close()
	



	//// LowerChestRight Drawing
	lowerChestRightPath = UIBezierPath()
	lowerChestRightPath.move(to: CGPoint(x: 139.44, y: 182.93))
	lowerChestRightPath.addLine(to: CGPoint(x: 148.38, y: 176.22))
	lowerChestRightPath.addLine(to: CGPoint(x: 185.27, y: 164.13))
	lowerChestRightPath.addLine(to: CGPoint(x: 186.61, y: 165.83))
	lowerChestRightPath.addLine(to: CGPoint(x: 186.61, y: 196.49))
	lowerChestRightPath.addLine(to: CGPoint(x: 184.41, y: 211.39))
	lowerChestRightPath.addLine(to: CGPoint(x: 178.41, y: 221.65))
	lowerChestRightPath.addLine(to: CGPoint(x: 173.87, y: 225.07))
	lowerChestRightPath.addLine(to: CGPoint(x: 161.74, y: 231.42))
	lowerChestRightPath.addLine(to: CGPoint(x: 156.22, y: 232.4))
	lowerChestRightPath.addLine(to: CGPoint(x: 151.81, y: 232.4))
	lowerChestRightPath.addLine(to: CGPoint(x: 147.4, y: 229.34))
	lowerChestRightPath.addLine(to: CGPoint(x: 143.36, y: 222.99))
	lowerChestRightPath.addLine(to: CGPoint(x: 137.73, y: 205.53))
	lowerChestRightPath.addLine(to: CGPoint(x: 139.44, y: 182.93))
	lowerChestRightPath.close()
	



	//// CalfRight3 Drawing
	calfRight3Path = UIBezierPath()
	calfRight3Path.move(to: CGPoint(x: 539.37, y: 566.81))
	calfRight3Path.addLine(to: CGPoint(x: 546.23, y: 553.01))
	calfRight3Path.addLine(to: CGPoint(x: 553.96, y: 545.31))
	calfRight3Path.addLine(to: CGPoint(x: 558.11, y: 554.48))
	calfRight3Path.addLine(to: CGPoint(x: 565.72, y: 547.64))
	calfRight3Path.addLine(to: CGPoint(x: 570.13, y: 539.21))
	calfRight3Path.addLine(to: CGPoint(x: 577.84, y: 554.97))
	calfRight3Path.addLine(to: CGPoint(x: 579.8, y: 571.94))
	calfRight3Path.addLine(to: CGPoint(x: 582.13, y: 589.28))
	calfRight3Path.addLine(to: CGPoint(x: 582.87, y: 610.66))
	calfRight3Path.addLine(to: CGPoint(x: 579.8, y: 634.47))
	calfRight3Path.addLine(to: CGPoint(x: 576.62, y: 670.01))
	calfRight3Path.addLine(to: CGPoint(x: 575.64, y: 695.67))
	calfRight3Path.addLine(to: CGPoint(x: 575.52, y: 707.51))
	calfRight3Path.addLine(to: CGPoint(x: 565.46, y: 716.68))
	calfRight3Path.addLine(to: CGPoint(x: 558.48, y: 727.17))
	calfRight3Path.addLine(to: CGPoint(x: 554.68, y: 729.38))
	calfRight3Path.addLine(to: CGPoint(x: 547.33, y: 728.4))
	calfRight3Path.addLine(to: CGPoint(x: 548.56, y: 685.04))
	calfRight3Path.addLine(to: CGPoint(x: 545.5, y: 665.25))
	calfRight3Path.addLine(to: CGPoint(x: 543.78, y: 643.4))
	calfRight3Path.addLine(to: CGPoint(x: 537.29, y: 626.17))
	calfRight3Path.addLine(to: CGPoint(x: 536.43, y: 600.03))
	calfRight3Path.addLine(to: CGPoint(x: 539.37, y: 566.81))
	calfRight3Path.close()
	



	//// CalfLeft3 Drawing
	calfLeft3Path = UIBezierPath()
	calfLeft3Path.move(to: CGPoint(x: 477.73, y: 544.34))
	calfLeft3Path.addLine(to: CGPoint(x: 475.05, y: 550.32))
	calfLeft3Path.addLine(to: CGPoint(x: 474.68, y: 554.84))
	calfLeft3Path.addLine(to: CGPoint(x: 467.32, y: 549.11))
	calfLeft3Path.addLine(to: CGPoint(x: 460.58, y: 539.21))
	calfLeft3Path.addLine(to: CGPoint(x: 456.17, y: 548.98))
	calfLeft3Path.addLine(to: CGPoint(x: 451.27, y: 556.55))
	calfLeft3Path.addLine(to: CGPoint(x: 449.56, y: 578.42))
	calfLeft3Path.addLine(to: CGPoint(x: 447.84, y: 596.12))
	calfLeft3Path.addLine(to: CGPoint(x: 448.94, y: 608.58))
	calfLeft3Path.addLine(to: CGPoint(x: 452.01, y: 646.44))
	calfLeft3Path.addLine(to: CGPoint(x: 453.97, y: 669.52))
	calfLeft3Path.addLine(to: CGPoint(x: 455.81, y: 694.69))
	calfLeft3Path.addLine(to: CGPoint(x: 455.56, y: 699.94))
	calfLeft3Path.addLine(to: CGPoint(x: 463.65, y: 711.3))
	calfLeft3Path.addLine(to: CGPoint(x: 470.64, y: 720.33))
	calfLeft3Path.addLine(to: CGPoint(x: 479.2, y: 726.94))
	calfLeft3Path.addLine(to: CGPoint(x: 484.48, y: 727.17))
	calfLeft3Path.addLine(to: CGPoint(x: 483.5, y: 711.91))
	calfLeft3Path.addLine(to: CGPoint(x: 482.14, y: 695.79))
	calfLeft3Path.addLine(to: CGPoint(x: 485.58, y: 664.15))
	calfLeft3Path.addLine(to: CGPoint(x: 487.79, y: 642.91))
	calfLeft3Path.addLine(to: CGPoint(x: 495.26, y: 624.34))
	calfLeft3Path.addLine(to: CGPoint(x: 493.91, y: 591.84))
	calfLeft3Path.addLine(to: CGPoint(x: 491.09, y: 572.79))
	calfLeft3Path.addLine(to: CGPoint(x: 489.75, y: 562.41))
	calfLeft3Path.addLine(to: CGPoint(x: 484.23, y: 552.4))
	calfLeft3Path.addLine(to: CGPoint(x: 477.73, y: 544.34))
	calfLeft3Path.close()
	



	//// Core Drawing
	corePath = UIBezierPath()
	corePath.move(to: CGPoint(x: 161.74, y: 231.55))
	corePath.addLine(to: CGPoint(x: 173.78, y: 225))
	corePath.addLine(to: CGPoint(x: 198.99, y: 223.97))
	corePath.addLine(to: CGPoint(x: 217.12, y: 229.71))
	corePath.addLine(to: CGPoint(x: 221.66, y: 243.88))
	corePath.addLine(to: CGPoint(x: 221.66, y: 260.86))
	corePath.addLine(to: CGPoint(x: 221.66, y: 266.35))
	corePath.addLine(to: CGPoint(x: 223.62, y: 276.02))
	corePath.addLine(to: CGPoint(x: 226.8, y: 287.61))
	corePath.addLine(to: CGPoint(x: 226.8, y: 303.11))
	corePath.addLine(to: CGPoint(x: 225.82, y: 322.78))
	corePath.addLine(to: CGPoint(x: 224.84, y: 330.24))
	corePath.addLine(to: CGPoint(x: 219.7, y: 340.5))
	corePath.addLine(to: CGPoint(x: 219.7, y: 357.96))
	corePath.addLine(to: CGPoint(x: 208.06, y: 397.17))
	corePath.addLine(to: CGPoint(x: 194.34, y: 396.88))
	corePath.addLine(to: CGPoint(x: 189.31, y: 391.21))
	corePath.addLine(to: CGPoint(x: 178.9, y: 366.99))
	corePath.addLine(to: CGPoint(x: 176.69, y: 355.3))
	corePath.addLine(to: CGPoint(x: 176.69, y: 342.32))
	corePath.addLine(to: CGPoint(x: 166.28, y: 325.35))
	corePath.addLine(to: CGPoint(x: 165.04, y: 311.06))
	corePath.addLine(to: CGPoint(x: 162.1, y: 302.26))
	corePath.addLine(to: CGPoint(x: 160.14, y: 267.82))
	corePath.addLine(to: CGPoint(x: 156.93, y: 259.62))
	corePath.addLine(to: CGPoint(x: 156.63, y: 246.22))
	corePath.addLine(to: CGPoint(x: 161.74, y: 231.55))
	corePath.close()
	



	//// LowerBack Drawing
	lowerBackPath = UIBezierPath()
	lowerBackPath.move(to: CGPoint(x: 488.15, y: 340.98))
	lowerBackPath.addLine(to: CGPoint(x: 489.38, y: 327.67))
	lowerBackPath.addLine(to: CGPoint(x: 486.56, y: 308.98))
	lowerBackPath.addLine(to: CGPoint(x: 491.58, y: 298.84))
	lowerBackPath.addLine(to: CGPoint(x: 500.9, y: 290.41))
	lowerBackPath.addLine(to: CGPoint(x: 510.34, y: 280.64))
	lowerBackPath.addLine(to: CGPoint(x: 517.31, y: 274.17))
	lowerBackPath.addLine(to: CGPoint(x: 519.88, y: 274.17))
	lowerBackPath.addLine(to: CGPoint(x: 522.46, y: 250.48))
	lowerBackPath.addLine(to: CGPoint(x: 525.65, y: 230.69))
	lowerBackPath.addLine(to: CGPoint(x: 529.94, y: 198.93))
	lowerBackPath.addLine(to: CGPoint(x: 527.49, y: 171.95))
	lowerBackPath.addLine(to: CGPoint(x: 523.57, y: 161.92))
	lowerBackPath.addLine(to: CGPoint(x: 520.01, y: 148.37))
	lowerBackPath.addLine(to: CGPoint(x: 517.92, y: 141.77))
	lowerBackPath.addLine(to: CGPoint(x: 516.45, y: 128.1))
	lowerBackPath.addLine(to: CGPoint(x: 517.2, y: 120.65))
	lowerBackPath.addLine(to: CGPoint(x: 521.35, y: 114.3))
	lowerBackPath.addLine(to: CGPoint(x: 527.85, y: 110.75))
	lowerBackPath.addLine(to: CGPoint(x: 535.08, y: 117.23))
	lowerBackPath.addLine(to: CGPoint(x: 538.76, y: 129.32))
	lowerBackPath.addLine(to: CGPoint(x: 545.13, y: 164.37))
	lowerBackPath.addLine(to: CGPoint(x: 541.08, y: 193.07))
	lowerBackPath.addLine(to: CGPoint(x: 540.84, y: 218.97))
	lowerBackPath.addLine(to: CGPoint(x: 536.67, y: 244.74))
	lowerBackPath.addLine(to: CGPoint(x: 534.59, y: 276.5))
	lowerBackPath.addLine(to: CGPoint(x: 538.02, y: 275.88))
	lowerBackPath.addLine(to: CGPoint(x: 544.27, y: 281.38))
	lowerBackPath.addLine(to: CGPoint(x: 548.19, y: 287.85))
	lowerBackPath.addLine(to: CGPoint(x: 552.6, y: 306.42))
	lowerBackPath.addLine(to: CGPoint(x: 548.68, y: 322.91))
	lowerBackPath.addLine(to: CGPoint(x: 551.99, y: 330.73))
	lowerBackPath.addLine(to: CGPoint(x: 558.24, y: 332.68))
	lowerBackPath.addLine(to: CGPoint(x: 538.63, y: 349.41))
	lowerBackPath.addLine(to: CGPoint(x: 528.96, y: 355.27))
	lowerBackPath.addLine(to: CGPoint(x: 524.67, y: 363.82))
	lowerBackPath.addLine(to: CGPoint(x: 522.33, y: 369.07))
	lowerBackPath.addLine(to: CGPoint(x: 513.64, y: 368.95))
	lowerBackPath.addLine(to: CGPoint(x: 507.14, y: 359.06))
	lowerBackPath.addLine(to: CGPoint(x: 505.18, y: 352.22))
	lowerBackPath.addLine(to: CGPoint(x: 488.15, y: 340.98))
	lowerBackPath.close()
	



	//// UpperTrapLeft Drawing
	upperTrapLeftPath = UIBezierPath()
	upperTrapLeftPath.move(to: CGPoint(x: 228.89, y: 124.3))
	upperTrapLeftPath.addLine(to: CGPoint(x: 223.5, y: 135.54))
	upperTrapLeftPath.addLine(to: CGPoint(x: 234.52, y: 155.34))
	upperTrapLeftPath.addLine(to: CGPoint(x: 245.91, y: 155.34))
	upperTrapLeftPath.addLine(to: CGPoint(x: 259.4, y: 148.01))
	upperTrapLeftPath.addLine(to: CGPoint(x: 249.31, y: 144.22))
	upperTrapLeftPath.addLine(to: CGPoint(x: 241.87, y: 140.06))
	upperTrapLeftPath.addLine(to: CGPoint(x: 236.6, y: 136.52))
	upperTrapLeftPath.addLine(to: CGPoint(x: 231.95, y: 131.03))
	upperTrapLeftPath.addLine(to: CGPoint(x: 228.89, y: 124.3))
	upperTrapLeftPath.close()
	



	//// Core Right Drawing
	coreRightPath = UIBezierPath()
	coreRightPath.move(to: CGPoint(x: 143.61, y: 223.12))
	coreRightPath.addLine(to: CGPoint(x: 147.35, y: 229.38))
	coreRightPath.addLine(to: CGPoint(x: 151.58, y: 232.27))
	coreRightPath.addLine(to: CGPoint(x: 156.84, y: 232.39))
	coreRightPath.addLine(to: CGPoint(x: 153.15, y: 237.16))
	coreRightPath.addLine(to: CGPoint(x: 155.5, y: 239))
	coreRightPath.addLine(to: CGPoint(x: 154.52, y: 246.81))
	coreRightPath.addLine(to: CGPoint(x: 154.52, y: 251.09))
	coreRightPath.addLine(to: CGPoint(x: 150.96, y: 252.92))
	coreRightPath.addLine(to: CGPoint(x: 153.6, y: 255.55))
	coreRightPath.addLine(to: CGPoint(x: 154.63, y: 261.59))
	coreRightPath.addLine(to: CGPoint(x: 155.62, y: 269.4))
	coreRightPath.addLine(to: CGPoint(x: 152.3, y: 270.63))
	coreRightPath.addLine(to: CGPoint(x: 155.62, y: 272.59))
	coreRightPath.addLine(to: CGPoint(x: 156.48, y: 276.24))
	coreRightPath.addLine(to: CGPoint(x: 157.69, y: 290.66))
	coreRightPath.addLine(to: CGPoint(x: 154.88, y: 291.64))
	coreRightPath.addLine(to: CGPoint(x: 158.02, y: 297.65))
	coreRightPath.addLine(to: CGPoint(x: 158.02, y: 301.53))
	coreRightPath.addLine(to: CGPoint(x: 160.52, y: 307.27))
	coreRightPath.addLine(to: CGPoint(x: 155.62, y: 312.16))
	coreRightPath.addLine(to: CGPoint(x: 162.74, y: 318.99))
	coreRightPath.addLine(to: CGPoint(x: 163.95, y: 330.84))
	coreRightPath.addLine(to: CGPoint(x: 168.97, y: 341.96))
	coreRightPath.addLine(to: CGPoint(x: 171.54, y: 347.45))
	coreRightPath.addLine(to: CGPoint(x: 165.04, y: 347.7))
	coreRightPath.addLine(to: CGPoint(x: 154.59, y: 341.66))
	coreRightPath.addLine(to: CGPoint(x: 146.42, y: 335.57))
	coreRightPath.addLine(to: CGPoint(x: 148.64, y: 330.73))
	coreRightPath.addLine(to: CGPoint(x: 146.19, y: 321.8))
	coreRightPath.addLine(to: CGPoint(x: 145.63, y: 306.06))
	coreRightPath.addLine(to: CGPoint(x: 149.12, y: 293.21))
	coreRightPath.addLine(to: CGPoint(x: 148.75, y: 279.72))
	coreRightPath.addLine(to: CGPoint(x: 147.17, y: 270.63))
	coreRightPath.addLine(to: CGPoint(x: 144.46, y: 245.35))
	coreRightPath.addLine(to: CGPoint(x: 143.61, y: 223.12))
	coreRightPath.close()
	



	//// CoreLeft Drawing
	coreLeftPath = UIBezierPath()
	coreLeftPath.move(to: CGPoint(x: 270.42, y: 191.24))
	coreLeftPath.addLine(to: CGPoint(x: 262.46, y: 185.74))
	coreLeftPath.addLine(to: CGPoint(x: 262.58, y: 201.3))
	coreLeftPath.addLine(to: CGPoint(x: 261.23, y: 205.29))
	coreLeftPath.addLine(to: CGPoint(x: 254.01, y: 216.52))
	coreLeftPath.addLine(to: CGPoint(x: 244.57, y: 226.05))
	coreLeftPath.addLine(to: CGPoint(x: 223.5, y: 230.2))
	coreLeftPath.addLine(to: CGPoint(x: 227.06, y: 233.74))
	coreLeftPath.addLine(to: CGPoint(x: 224.6, y: 236.55))
	coreLeftPath.addLine(to: CGPoint(x: 224.6, y: 244.49))
	coreLeftPath.addLine(to: CGPoint(x: 226.56, y: 248.52))
	coreLeftPath.addLine(to: CGPoint(x: 229.38, y: 249.63))
	coreLeftPath.addLine(to: CGPoint(x: 226.56, y: 252.92))
	coreLeftPath.addLine(to: CGPoint(x: 226.56, y: 267.45))
	coreLeftPath.addLine(to: CGPoint(x: 231.58, y: 269.89))
	coreLeftPath.addLine(to: CGPoint(x: 228.27, y: 272.1))
	coreLeftPath.addLine(to: CGPoint(x: 229.38, y: 280.4))
	coreLeftPath.addLine(to: CGPoint(x: 230.85, y: 288.71))
	coreLeftPath.addLine(to: CGPoint(x: 235.39, y: 289.92))
	coreLeftPath.addLine(to: CGPoint(x: 233.79, y: 295.18))
	coreLeftPath.addLine(to: CGPoint(x: 230.85, y: 297.74))
	coreLeftPath.addLine(to: CGPoint(x: 231.83, y: 309.1))
	coreLeftPath.addLine(to: CGPoint(x: 239.05, y: 310.21))
	coreLeftPath.addLine(to: CGPoint(x: 230.72, y: 315.7))
	coreLeftPath.addLine(to: CGPoint(x: 228.76, y: 329.75))
	coreLeftPath.addLine(to: CGPoint(x: 224.84, y: 341.83))
	coreLeftPath.addLine(to: CGPoint(x: 224.84, y: 353.07))
	coreLeftPath.addLine(to: CGPoint(x: 226.07, y: 356))
	coreLeftPath.addLine(to: CGPoint(x: 228.64, y: 349.29))
	coreLeftPath.addLine(to: CGPoint(x: 235.75, y: 345.25))
	coreLeftPath.addLine(to: CGPoint(x: 253.39, y: 338.66))
	coreLeftPath.addLine(to: CGPoint(x: 258.91, y: 331.7))
	coreLeftPath.addLine(to: CGPoint(x: 260.01, y: 320.09))
	coreLeftPath.addLine(to: CGPoint(x: 260.01, y: 309.1))
	coreLeftPath.addLine(to: CGPoint(x: 257.56, y: 298.97))
	coreLeftPath.addLine(to: CGPoint(x: 258.42, y: 283.27))
	coreLeftPath.addLine(to: CGPoint(x: 257.2, y: 266.54))
	coreLeftPath.addLine(to: CGPoint(x: 259.4, y: 258.05))
	coreLeftPath.addLine(to: CGPoint(x: 261.85, y: 217.99))
	coreLeftPath.addLine(to: CGPoint(x: 263.93, y: 212.01))
	coreLeftPath.addLine(to: CGPoint(x: 264.66, y: 204.8))
	coreLeftPath.addLine(to: CGPoint(x: 269.44, y: 198.07))
	coreLeftPath.addLine(to: CGPoint(x: 270.42, y: 191.24))
	coreLeftPath.close()
	



	//// CoreLeft2 Drawing
	coreLeft2Path = UIBezierPath()
	coreLeft2Path.move(to: CGPoint(x: 269.44, y: 198.45))
	coreLeft2Path.addLine(to: CGPoint(x: 265.09, y: 204.72))
	coreLeft2Path.addLine(to: CGPoint(x: 263.95, y: 211.76))
	coreLeft2Path.addLine(to: CGPoint(x: 262.09, y: 218.11))
	coreLeft2Path.addLine(to: CGPoint(x: 260.38, y: 242.53))
	coreLeft2Path.addLine(to: CGPoint(x: 259.4, y: 257.8))
	coreLeft2Path.addLine(to: CGPoint(x: 257.44, y: 266.73))
	coreLeft2Path.addLine(to: CGPoint(x: 258.42, y: 282.96))
	coreLeft2Path.addLine(to: CGPoint(x: 267.97, y: 261.38))
	coreLeft2Path.addLine(to: CGPoint(x: 271.44, y: 251.88))
	coreLeft2Path.addLine(to: CGPoint(x: 273.61, y: 249.26))
	coreLeft2Path.addLine(to: CGPoint(x: 269.57, y: 231.08))
	coreLeft2Path.addLine(to: CGPoint(x: 269.44, y: 198.45))
	coreLeft2Path.close()
	



	//// UpperTrapRight Drawing
	upperTrapRightPath = UIBezierPath()
	upperTrapRightPath.move(to: CGPoint(x: 153.96, y: 154.18))
	upperTrapRightPath.addLine(to: CGPoint(x: 157.46, y: 157.74))
	upperTrapRightPath.addLine(to: CGPoint(x: 161.5, y: 158.76))
	upperTrapRightPath.addLine(to: CGPoint(x: 178.28, y: 158.63))
	upperTrapRightPath.addLine(to: CGPoint(x: 180.98, y: 155.94))
	upperTrapRightPath.addLine(to: CGPoint(x: 181.9, y: 142.51))
	upperTrapRightPath.addLine(to: CGPoint(x: 167.99, y: 150.45))
	upperTrapRightPath.addLine(to: CGPoint(x: 162.24, y: 153.27))
	upperTrapRightPath.addLine(to: CGPoint(x: 153.96, y: 154.18))
	upperTrapRightPath.close()
	



	//// SideDeltRight Drawing
	sideDeltRightPath = UIBezierPath()
	sideDeltRightPath.move(to: CGPoint(x: 147.4, y: 158.5))
	sideDeltRightPath.addLine(to: CGPoint(x: 139.81, y: 158.39))
	sideDeltRightPath.addLine(to: CGPoint(x: 134.17, y: 161.56))
	sideDeltRightPath.addLine(to: CGPoint(x: 129.15, y: 165.22))
	sideDeltRightPath.addLine(to: CGPoint(x: 123.51, y: 172.06))
	sideDeltRightPath.addLine(to: CGPoint(x: 119.35, y: 178.79))
	sideDeltRightPath.addLine(to: CGPoint(x: 116.78, y: 188.3))
	sideDeltRightPath.addLine(to: CGPoint(x: 116.78, y: 198.33))
	sideDeltRightPath.addLine(to: CGPoint(x: 117.76, y: 206.51))
	sideDeltRightPath.addLine(to: CGPoint(x: 119.72, y: 215.3))
	sideDeltRightPath.addLine(to: CGPoint(x: 120.95, y: 223.3))
	sideDeltRightPath.addLine(to: CGPoint(x: 123.76, y: 216.92))
	sideDeltRightPath.addLine(to: CGPoint(x: 121.19, y: 201.73))
	sideDeltRightPath.addLine(to: CGPoint(x: 121.19, y: 188.43))
	sideDeltRightPath.addLine(to: CGPoint(x: 122.53, y: 179.51))
	sideDeltRightPath.addLine(to: CGPoint(x: 126.52, y: 172.67))
	sideDeltRightPath.addLine(to: CGPoint(x: 131.23, y: 166.81))
	sideDeltRightPath.addLine(to: CGPoint(x: 138.46, y: 162.05))
	sideDeltRightPath.addLine(to: CGPoint(x: 147.4, y: 158.5))
	sideDeltRightPath.close()
	



	//// FrontDeltRight Drawing
	frontDeltRightPath = UIBezierPath()
	frontDeltRightPath.move(to: CGPoint(x: 159.16, y: 161.32))
	frontDeltRightPath.addLine(to: CGPoint(x: 147.28, y: 158.5))
	frontDeltRightPath.addLine(to: CGPoint(x: 138.46, y: 162.05))
	frontDeltRightPath.addLine(to: CGPoint(x: 131.48, y: 166.57))
	frontDeltRightPath.addLine(to: CGPoint(x: 127.07, y: 171.69))
	frontDeltRightPath.addLine(to: CGPoint(x: 122.66, y: 179.39))
	frontDeltRightPath.addLine(to: CGPoint(x: 121.19, y: 188.07))
	frontDeltRightPath.addLine(to: CGPoint(x: 121.19, y: 201.01))
	frontDeltRightPath.addLine(to: CGPoint(x: 123.76, y: 216.15))
	frontDeltRightPath.addLine(to: CGPoint(x: 127.19, y: 208.53))
	frontDeltRightPath.addLine(to: CGPoint(x: 130.62, y: 200.52))
	frontDeltRightPath.addLine(to: CGPoint(x: 138.71, y: 192.21))
	frontDeltRightPath.addLine(to: CGPoint(x: 139.69, y: 182.7))
	frontDeltRightPath.addLine(to: CGPoint(x: 141.65, y: 172.44))
	frontDeltRightPath.addLine(to: CGPoint(x: 159.16, y: 161.32))
	frontDeltRightPath.close()
	



	//// BicepsLeft Drawing
	bicepsLeftPath = UIBezierPath()
	bicepsLeftPath.move(to: CGPoint(x: 295.05, y: 227.03))
	bicepsLeftPath.addLine(to: CGPoint(x: 297.75, y: 243.15))
	bicepsLeftPath.addLine(to: CGPoint(x: 299.33, y: 271.12))
	bicepsLeftPath.addLine(to: CGPoint(x: 293.94, y: 284.31))
	bicepsLeftPath.addLine(to: CGPoint(x: 285.61, y: 278.69))
	bicepsLeftPath.addLine(to: CGPoint(x: 278.39, y: 286.5))
	bicepsLeftPath.addLine(to: CGPoint(x: 278.39, y: 266.73))
	bicepsLeftPath.addLine(to: CGPoint(x: 273.61, y: 248.52))
	bicepsLeftPath.addLine(to: CGPoint(x: 269.69, y: 231.55))
	bicepsLeftPath.addLine(to: CGPoint(x: 269.69, y: 200.89))
	bicepsLeftPath.addLine(to: CGPoint(x: 270.65, y: 191.79))
	bicepsLeftPath.addLine(to: CGPoint(x: 288.32, y: 215.06))
	bicepsLeftPath.addLine(to: CGPoint(x: 295.05, y: 227.03))
	bicepsLeftPath.close()
	



	//// BicepsLeft2 Drawing
	bicepsLeft2Path = UIBezierPath()
	bicepsLeft2Path.move(to: CGPoint(x: 294.92, y: 226.54))
	bicepsLeft2Path.addLine(to: CGPoint(x: 297.86, y: 242.9))
	bicepsLeft2Path.addLine(to: CGPoint(x: 299.46, y: 271))
	bicepsLeft2Path.addLine(to: CGPoint(x: 306.45, y: 258.46))
	bicepsLeft2Path.addLine(to: CGPoint(x: 310.62, y: 244.53))
	bicepsLeft2Path.addLine(to: CGPoint(x: 310.98, y: 231.18))
	bicepsLeft2Path.addLine(to: CGPoint(x: 307.3, y: 219.45))
	bicepsLeft2Path.addLine(to: CGPoint(x: 302.04, y: 205.81))
	bicepsLeft2Path.addLine(to: CGPoint(x: 294.92, y: 226.54))
	bicepsLeft2Path.close()
	



	//// LowerTrapLeft Drawing
	lowerTrapLeftPath = UIBezierPath()
	lowerTrapLeftPath.move(to: CGPoint(x: 523.57, y: 162.18))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 498.45, y: 154.48))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 506.16, y: 160.46))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 507.76, y: 167.3))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 505.92, y: 183.3))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 504.69, y: 203.33))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 502.86, y: 213.59))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 507.51, y: 231.55))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 512.9, y: 247.06))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 515.84, y: 254.87))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 517.69, y: 264.89))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 517.43, y: 274.05))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 519.88, y: 274.17))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 522.22, y: 251.33))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 526.51, y: 224.94))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 529.69, y: 198.69))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 527, y: 171.58))
	lowerTrapLeftPath.addLine(to: CGPoint(x: 523.57, y: 162.18))
	lowerTrapLeftPath.close()
	



	//// LowerTrapRight Drawing
	lowerTrapRightPath = UIBezierPath()
	lowerTrapRightPath.move(to: CGPoint(x: 545.13, y: 164.62))
	lowerTrapRightPath.addLine(to: CGPoint(x: 566.33, y: 154.36))
	lowerTrapRightPath.addLine(to: CGPoint(x: 561.67, y: 161.43))
	lowerTrapRightPath.addLine(to: CGPoint(x: 560.93, y: 168.89))
	lowerTrapRightPath.addLine(to: CGPoint(x: 562.89, y: 191.72))
	lowerTrapRightPath.addLine(to: CGPoint(x: 563.63, y: 202.96))
	lowerTrapRightPath.addLine(to: CGPoint(x: 564.25, y: 214.57))
	lowerTrapRightPath.addLine(to: CGPoint(x: 559.09, y: 225.92))
	lowerTrapRightPath.addLine(to: CGPoint(x: 552.6, y: 240.83))
	lowerTrapRightPath.addLine(to: CGPoint(x: 546.23, y: 251.82))
	lowerTrapRightPath.addLine(to: CGPoint(x: 539.25, y: 264.4))
	lowerTrapRightPath.addLine(to: CGPoint(x: 537.9, y: 275.88))
	lowerTrapRightPath.addLine(to: CGPoint(x: 534.84, y: 276.24))
	lowerTrapRightPath.addLine(to: CGPoint(x: 536.92, y: 243.88))
	lowerTrapRightPath.addLine(to: CGPoint(x: 540.84, y: 219.21))
	lowerTrapRightPath.addLine(to: CGPoint(x: 541.08, y: 193.07))
	lowerTrapRightPath.addLine(to: CGPoint(x: 545.13, y: 164.62))
	lowerTrapRightPath.close()
	



	//// UpperChestRight Drawing
	upperChestRightPath = UIBezierPath()
	upperChestRightPath.move(to: CGPoint(x: 159.16, y: 161.81))
	upperChestRightPath.addLine(to: CGPoint(x: 178.41, y: 161.32))
	upperChestRightPath.addLine(to: CGPoint(x: 185.39, y: 164.13))
	upperChestRightPath.addLine(to: CGPoint(x: 148.87, y: 175.97))
	upperChestRightPath.addLine(to: CGPoint(x: 139.44, y: 182.7))
	upperChestRightPath.addLine(to: CGPoint(x: 141.52, y: 172.67))
	upperChestRightPath.addLine(to: CGPoint(x: 159.16, y: 161.81))
	upperChestRightPath.close()
	

    }
}
