//
//  ShowOrderTableViewCell.swift
//  EasyApp
//
//  Created by Panupong Chaiyarut on 2/9/2562 BE.
//  Copyright © 2562 Panupong Chaiyarut. All rights reserved.
//

import UIKit

class ShowOrderTableViewCell: UITableViewCell {


//    @IBOutlet weak var imageViewFood: UIImageView!
//    @IBOutlet weak var lblFoodName: UILabel!
//    @IBOutlet weak var lblFoodPrice: UILabel!

    @IBOutlet weak var imageViewFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
  
    @IBOutlet weak var addCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
