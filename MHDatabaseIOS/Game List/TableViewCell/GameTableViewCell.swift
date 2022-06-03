//
//  GameTableViewCell.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/22/22.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
