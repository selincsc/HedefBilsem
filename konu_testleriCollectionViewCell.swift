//
//  konu_testleriCollectionViewCell.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit

class konu_testleriCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var view_outlet: view2_desing!{
        didSet{
            view_outlet.layer.cornerRadius = 12
        }
    }
    @IBAction func button_action(_ sender: Any) {
    }
    @IBOutlet weak var label_outlet: UILabel!
}
