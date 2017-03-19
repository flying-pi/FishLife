//
//  Fish.swift
//  FishLife
//
//  Created by Yura Braiko on 19.03.17.
//  Copyright © 2017 Yura Braiko. All rights reserved.
//

import Foundation
import UIKit

protocol BaseFish : IRenderProtocol{
    var xPos: Double{get set}
    var yPos: Double{get set}
    var size: Double{get set}
    
    func nextStep(_ neaby: [FieldCell])
}

enum FishType{
    case herb
    case predator
}


class HerbFish : BaseFish{
    //    let color: UIColor = UIColor.purple
    let color: UIColor
    var xPos: Double = 0
    var yPos: Double = 0
    var size: Double = 0.01
    var bpath:UIBezierPath? = nil ;
    var direction: Double = 0
    var speed: Double = 0.001
    let type = FishType.herb
    
    convenience public init(){
        self.init( Double(arc4random()) / Double(UInt32.max), Double(arc4random()) / Double(UInt32.max));
    }
    
    public init(_ x: Double, _ y: Double){
        xPos = x;
        yPos = y;
        direction = Double(arc4random()) / Double(UInt32.max)*2*Double.pi;
        color = UIColor(
            red: CGFloat(arc4random()) / CGFloat(UInt32.max),
            green: CGFloat(arc4random()) / CGFloat(UInt32.max),
            blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
            alpha: 1)
        //        bpath.move(to: CGPoint(x: 1, y: 2));
    }
    
    func render(pixelSize: CGFloat) {
        let pixelSize = Double(pixelSize)
        //        if(bpath == nil){
        //            let rect = CGRect(x: (xPos-size/2) * pixelSize,
        //                              y: (yPos-size/2) * pixelSize ,
        //                              width: size * pixelSize ,
        //                              height: size  * pixelSize)
        //            bpath = UIBezierPath(ovalIn:rect )
        //        }else{
        //            bpath?.move(to: CGPoint(x: (xPos-size/2) * pixelSize , y: (yPos-size/2) * pixelSize))
        //        }
        
        
        color.set()
        UIBezierPath(ovalIn:CGRect(x: (xPos-size/2) * pixelSize,
                                   y: (yPos-size/2) * pixelSize ,
                                   width: size * pixelSize ,
                                   height: size  * pixelSize) ).fill()
        
        //        bpath?.fill()
    }
    func nextStep(_ neaby: [FieldCell]) {
        xPos += cos(direction) * speed
        yPos += sin(direction) * speed
        
        if(xPos<0){
            xPos = 1
        }
        if(xPos > 1){
            xPos = 0
        }
        
        if(yPos<0){
            yPos = 1
        }
        if(yPos > 1){
            yPos = 0
        }
        
//        direction += Double(arc4random()) / Double(UInt32.max) * 0.6 - 0.3
    }
    
//    class PredatorFish:HerbFish{
//        
//    }
}
