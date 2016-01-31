//
//  ShowerCell.swift
//  Dripp
//
//  Created by Henry Saniuk on 1/31/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import UIKit

class ShowerCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var recommended: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photo.layer.borderWidth = 1
        photo.layer.borderColor = UIColor.lightGrayColor().CGColor
        photo.layer.cornerRadius = photo.frame.height/2
        photo.layer.masksToBounds = false
        photo.clipsToBounds = true
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
