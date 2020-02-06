//
//  CustomercategoryTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 5/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class CustomercategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categorylbl: UILabel!
    @IBOutlet weak var categoryimg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
