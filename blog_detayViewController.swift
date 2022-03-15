//
//  blog_detayViewController.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
class blog_detayViewController: MyController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBOutlet var content_view_outlet: UIScrollView!
    @IBOutlet weak var image_view_outlet: AnimatedImageView!{
        didSet{
            Url_To_Image(url: imageBaseURL + hedef["data"]["img_url"].stringValue, imageView: image_view_outlet)
            image_view_outlet.layer.cornerRadius = 12
        }
    }
    @IBAction func back_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController")
    }
    @IBOutlet weak var view_outlet: UIView!{
        didSet{
            view_outlet.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var label_outlet: UILabel!{
        didSet{
            label_outlet.text = hedef["data"]["desc"].stringValue
        }
    }
}
