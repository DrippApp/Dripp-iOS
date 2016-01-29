//
//  FeedCell.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/29/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    let color = UIColor.lightBlue
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let iconMock = UIView()
        iconMock.backgroundColor = color
        iconMock.frame = CGRect(x: 16, y: 16, width: 60, height: 60)
        iconMock.layer.cornerRadius = 10
        self.addSubview(iconMock)
        
        let sepalator = UIView()
        sepalator.frame = CGRect(x: 0, y: 92 - 1, width: frame.width, height: 1)
        sepalator.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
        self.addSubview(sepalator)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addLine(frame:CGRect) {
        let line = UIView(frame:frame)
        line.layer.cornerRadius = frame.height / 2
        line.backgroundColor = color
        self.addSubview(line)
    }
}
