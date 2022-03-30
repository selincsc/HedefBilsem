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
            view_outlet.backgroundColor = .clear
        }
    }
    @IBOutlet weak var label_outlet: UILabel!{
        didSet{
            label_outlet.text = hedef["data"]["desc"].stringValue.htmlToString
        }
    }
}
extension String{
    private var htmlToAttributedString: NSAttributedString? {
            guard let data = data(using: .utf8) else { return nil }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            } catch {
                return nil
            }
        }
        var htmlToString: String {
            return htmlToAttributedString?.string ?? ""
        }
}
