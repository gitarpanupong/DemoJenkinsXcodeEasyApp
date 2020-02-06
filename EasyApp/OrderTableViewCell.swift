//
//  OrderTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    

    @IBOutlet weak var foodNamelbl: UILabel!
    @IBOutlet weak var foodPricelbl: UILabel!
    @IBOutlet weak var amountlbl: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


