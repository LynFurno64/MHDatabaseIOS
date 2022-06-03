//
//  TrapCollectionViewCell.swift
//  MHDatabaseIOS
//
//  Created by Che Alexander on 6/1/22.
//

import UIKit

class TrapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageViewB: UIImageView!

    static let identifier = "TrapCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TrapCollectionViewCell", bundle: nil)
    }

}
