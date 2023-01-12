//
//  PickerState.swift
//  vkCup
//
//  Created by iMac iOS Павел on 05.12.2022.
//

import UIKit

struct Category {
    let id: Int
    let title: String
    var checked: Bool
    var cellSize: CGSize = .zero
}

struct PickerState {
    var categories: [Category] = []
    
    init(from titles: [String]) {
        var id = 0
        
        for title in titles {
            let label = UILabel(frame: CGRect.zero)
            label.text = title
            label.font = .boldSystemFont(ofSize: 16)
            label.sizeToFit()
            
            categories.append(Category(id: id,
                                       title: title,
                                       checked: false,
                                       cellSize: CGSize(width: label.frame.width + 73, height: 46)))
            id += 1
        }
    }
}
