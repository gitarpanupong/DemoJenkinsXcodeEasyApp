//
//  ResTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 30/10/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class ResTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var resName: UILabel!
    @IBOutlet weak var resImage: UIImageView!
    @IBOutlet weak var resPhone: UILabel!
    
    @IBOutlet weak var resPlace: UILabel!
    
    @IBOutlet weak var resTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
