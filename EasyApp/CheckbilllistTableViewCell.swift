//
//  CheckbilllistTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class CheckbilllistTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var foodnamelbl: UILabel!
    @IBOutlet weak var foodpricelbl: UILabel!
    @IBOutlet weak var foodquantitylbl: UILabel!
    @IBOutlet weak var foodamountlbl: UILabel!
    
    @IBOutlet weak var btnplus: UIButton!
    @IBOutlet weak var btnminus: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
