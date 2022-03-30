//
//  bloglar_TableViewCell.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit
import Kingfisher
class bloglar_TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var view_outlet: UIView!
    @IBOutlet weak var image_view_outlet: AnimatedImageView!
    @IBOutlet weak var label_outlet: UILabel!
    
}
