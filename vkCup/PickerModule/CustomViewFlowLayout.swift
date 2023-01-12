//
//  CustomViewFlowLayout.swift
//  vkCup
//
//  Created by iMac iOS Павел on 08.12.2022.
//

import UIKit

class CustomViewFlowLayout: UICollectionViewFlowLayout {
    let cellSpacing: CGFloat = 8

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 8
        self.sectionInset = UIEdgeInsets(top: 12.0, left: 16.0, bottom: 0.0, right: 16.0)
        let attributes = super.layoutAttributesForElements(in: rect)
        var attributesCopy = [UICollectionViewLayoutAttributes]()

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            let layoutAttributesCopy = layoutAttribute.copy() as! UICollectionViewLayoutAttributes
            
            if layoutAttributesCopy.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttributesCopy.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + cellSpacing
            maxY = max(layoutAttributesCopy.frame.maxY, maxY)
            
            attributesCopy.append(layoutAttributesCopy)
        }
        
        return attributesCopy
    }
}
