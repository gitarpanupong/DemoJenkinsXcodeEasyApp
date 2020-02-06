//
//  CustomerTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 18/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class CustomerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cusStatuslbl: UILabel!
    
    @IBOutlet weak var cusNamelbl: UILabel!
    
    @IBOutlet weak var totallbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
