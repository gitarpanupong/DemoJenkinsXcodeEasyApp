//
//  WaterTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 26/7/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class WaterTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewWater: UIImageView!
    @IBOutlet weak var lblWaterName: UILabel!
    @IBOutlet weak var lblWaterPrice: UILabel!
    
    @IBOutlet weak var waterextralbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
