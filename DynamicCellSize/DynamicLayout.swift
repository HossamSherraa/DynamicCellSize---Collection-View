//
//  DynamicLayout.swift
//  DynamicCellSize
//
//  Created by Hossam on 9/26/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit

class DynamicLayout : UICollectionViewLayout {
    
    var flage = true
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate  var contentHeight : CGFloat = 0
    var minumumInterItemSpace : CGFloat = 30
    
    fileprivate var sizesOfItems = [IndexPath:CGSize]()
    override var collectionViewContentSize: CGSize {
        return CGSize.init(width: self.collectionView!.bounds.width, height: contentHeight)
    }
    override func prepare() {
        super.prepare()
         print(#function)
       cache.removeAll()
        
        
        var y : CGFloat = UIApplication.shared.statusBarFrame.maxY
        var frame = CGRect.zero
        
        for item in 0..<self.collectionView!.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            if let height = self.sizesOfItems[indexPath] {
              
                frame = CGRect.init(x: 0, y: y, width: UIScreen.main.bounds.width, height: height.height)}
            
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY + minumumInterItemSpace
            contentHeight = frame.maxY
            
        }
        
        
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
      
        return cache.filter{$0.frame.intersects(rect)}
    }
    
   
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
         print(#function)
        if let  oldSize = self.sizesOfItems[originalAttributes.indexPath] , oldSize != preferredAttributes.size  {
            print("Entere")
            self.sizesOfItems[originalAttributes.indexPath] = preferredAttributes.size
            DispatchQueue.main.async { [unowned self] in
                 self.invalidateLayout()
            }
          
            }
       
        if (originalAttributes.size != preferredAttributes.size && self.sizesOfItems[originalAttributes.indexPath] == nil && (self.layoutAttributesForElements(in: self.collectionView!.bounds)?.contains(originalAttributes))!)  {
        return true
            
        }
        return false
    }
    
   
    override func invalidationContext(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutInvalidationContext {
         print(#function)
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes, withOriginalAttributes: originalAttributes)
         self.sizesOfItems.updateValue(preferredAttributes.size, forKey: originalAttributes.indexPath)
        context.invalidateItems(at: [originalAttributes.indexPath])
        return context

    }
    
   
    
    
}
