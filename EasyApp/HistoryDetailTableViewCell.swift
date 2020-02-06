//
//  HistoryDetailTableViewCell.swift
//  FirebaseAuth
//
//  Created by Panupong Chaiyarut on 14/11/2562 BE.
//

import UIKit

class HistoryDetailTableViewCell: UITableViewCell {

   // @IBOutlet weak var foodnamelbl: UILabel!
    
    @IBOutlet weak var foodnamelbl: UILabel!
    @IBOutlet weak var foodquantitylbl: UILabel!
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
