//
//  FishPool.swift
//  FishLife
//
//  Created by Yura Braiko on 19.03.17.
//  Copyright © 2017 Yura Braiko. All rights reserved.
//

import UIKit

class FishPool: UIView {
    let poolSizeInCell = 10;
    let cellsCount: Int;
    let step: Double
    let defaultFishSize: Double
    let poolCells: [FieldCell]
    
    var timer: Timer?;
    
    
    required init?(coder aDecoder: NSCoder) {
        cellsCount = poolSizeInCell*poolSizeInCell;
        step = 1.0/(Double(poolSizeInCell-2))
        defaultFishSize = step/20.0;
        let lastTop = -step;
        let lastLeft = -step;
        let s = poolSizeInCell;
        let st = self.step;
        poolCells = (0..<cellsCount).map({(x: Int) -> FieldCell in FieldCell(
            Double(x/s)*st+lastTop,
            Double(x%s+1)*st+lastLeft,
            Double(x/s+1)*st+lastTop,
            Double(x%s)*st+lastLeft)});
        
        let offsets : [Int] = [1,-1,
                               poolSizeInCell,poolSizeInCell-1,poolSizeInCell+1,
                               -poolSizeInCell,-poolSizeInCell-1,-poolSizeInCell+1]
        let cc = cellsCount;
        for i  in 0..<cc{
            for offsetItem in offsets {
                let offset = i + offsetItem
                if offset >= 0 && offset < cc{
                    if i%s == 0 && (offset + 1) % s == 0 {
                        continue
                    }
                    if (i + 1 ) % s == 0 && offset % s == 0 {
                        continue
                    }
                    poolCells[i].addNearby(poolCells[offset])
                }
            }
        }
        
        
        super.init(coder: aDecoder)
        
        timer = Timer.scheduledTimer(timeInterval: 0.033, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        addFish(1000)

    }
    
    func update() {
        
        self.setNeedsDisplay()
    }
    
    public func addFish(_ count: Int){
        let size: Double = Double(poolSizeInCell-2)
        for _ in 0..<count{
//            let newFish: HerbFish = HerbFish(0.5,0.5);
            let newFish: HerbFish = HerbFish();
            newFish.size = defaultFishSize;
            let x = Int(newFish.xPos*size)
            let y = Int(newFish.yPos*size)
            poolCells[y*poolSizeInCell+x].addFish(newFish);
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let size = frame.width>frame.height ? frame.width : frame.height
        for cell in poolCells
        {
            cell.render(pixelSize: size)
        }
//        poolCells.forEach({cell in cell.render(pixelSize: size)})
    }
    
    
}
