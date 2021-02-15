//
//  MYCell.swift
//  DynamicCellSize
//
//  Created by Hossam on 9/26/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class MyCell : UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    var isCollectionViewBoundsChanged = false
    var isFirstLoad = true
    var counter = 0
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
      
         
            
        let size = textLabel.systemLayoutSizeFitting(.init(width: UIScreen.main.bounds.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        layoutAttributes.size = size
            
           
           
        
        
        return layoutAttributes
    }
    
   
}


    
    

