//
//  CustomCollectionViewCell.swift
//  NotTouchWhite
//
//  Created by ning on 16/12/7.
//  Copyright © 2016年 songjk. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
