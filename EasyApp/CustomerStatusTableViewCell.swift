//
//  CustomerStatusTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 3/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class CustomerStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var foodnamelbl: UILabel!
    @IBOutlet weak var foodquantitylbl: UILabel!
    
    @IBOutlet weak var foodstatuslbl: UILabel!
    @IBOutlet weak var foodtablelbl: UILabel!
    
    @IBOutlet weak var stepperOrder: UIStepper!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
