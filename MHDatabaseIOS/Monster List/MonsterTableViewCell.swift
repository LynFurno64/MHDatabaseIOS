//
//  MonsterTableViewCell.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 5/29/22.
//

import UIKit

class MonsterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myTumbnail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
