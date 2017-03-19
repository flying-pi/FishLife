//
//  FieldCell.swift
//  FishLife
//
//  Created by Yura Braiko on 19.03.17.
//  Copyright © 2017 Yura Braiko. All rights reserved.
//

import Foundation
import UIKit

class FieldCell: IRenderProtocol {
    private let top: Double;
    private let right: Double;
    private let bottom: Double;
    private let left: Double;
    private var nearCell = [FieldCell]()
    private var fishes = [BaseFish]()
    
    public init(_ top: Double,_ right: Double,_ bottom: Double,_ left: Double){
        self.top = top;
        self.right = right;
        self.bottom = bottom;
        self.left = left;
        nearCell.append(self)
    }
    
    public func addNearby(_ cell:FieldCell){
        nearCell.append(cell)
    }
    
    public func addFish(_ fish: BaseFish){
        fishes.append(fish)
    }
    
    func render(pixelSize: CGFloat) {
        for bf in fishes {
            bf.nextStep(nearCell)
            bf.render(pixelSize: pixelSize)
        }
//        fishes.forEach { bf in bf.render(pixelSize: pixelSize) }
    }
    
    func nextStep(){
        
        for bf in fishes {
            bf.nextStep(nearCell)
        }
//        fishes.forEach { bf in bf.nextStep(nearCell) }
    }
    
}
