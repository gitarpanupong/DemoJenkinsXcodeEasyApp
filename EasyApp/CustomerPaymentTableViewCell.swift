//
//  CustomerPaymentTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 6/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class CustomerPaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var foodnamelbl: UILabel!
    @IBOutlet weak var foodquantitylbl: UILabel!
    @IBOutlet weak var foodsumlbl: UILabel!
    @IBOutlet weak var foodpricelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
