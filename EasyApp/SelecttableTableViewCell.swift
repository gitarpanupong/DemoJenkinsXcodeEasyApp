//
//  SelecttableTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 7/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class SelecttableTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tablenamelbl: UILabel!
    @IBOutlet weak var tablestatuslbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
