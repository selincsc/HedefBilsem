//
//  hafıza_ViewController.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 16.03.2022.
//

import UIKit

class haf_za_ViewController: MyController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("İÇERİK: \(hedef)")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var header_label_outlet: UILabel!{
        didSet{
            header_label_outlet.text = hedef["keywords"]["title"].stringValue
        }
    }
    @IBOutlet weak var soru_metin_label_outlet: UILabel!{
        didSet{
            soru_metin_label_outlet.text = hedef["keywords"]["desc"].stringValue
    }
    }
    @IBOutlet weak var hazırsan_label_outlet: UILabel!{
        didSet{
            hazırsan_label_outlet.text = hedef["keywords"]["hazirsan_text"].stringValue
        }
    }
    @IBAction func back_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController")
    }
    @IBOutlet weak var view_outlet: view2_desing!
    @IBAction func button_action(_ sender: Any) {
    }
    

}
