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

        // Do any additional setup after loading the view.
    }
    

    @IBAction func back_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController")
    }
    @IBOutlet weak var view_outlet: view2_desing!
    @IBAction func button_action(_ sender: Any) {
    }
    

}
