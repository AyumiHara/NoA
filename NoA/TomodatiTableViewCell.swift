//
//  TomodatiTableViewCell.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/28.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit

class TomodatiTableViewCell: UITableViewCell {
    
    @IBOutlet var kaoImageView : UIImageView!
    @IBOutlet var namaeLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
