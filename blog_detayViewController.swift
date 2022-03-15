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
            Url_To_Image(url: imageBaseURL + hedef["data"], imageView: <#T##AnimatedImageView#>)
        }
    }
    @IBOutlet weak var view_outlet: UIView!
    @IBOutlet weak var label_outlet: UILabel!
}
extension ViewController{
        //ALAMOFIRE JSON
    func hedef_blogdetay_list(id: String){
            let parameters : Parameters = [
                "user_id" : id,
            ]
            let url = apiURL + "/get_blog_detay"
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { [self]
                response in
                
                switch response.result {
                case .success(let value):
                    
                    hedef = JSON(value)
                    print(" gelen data: \(hedef)")
                    
                case .failure(let error):
                    Swift.print(error)
                }
            }
        }
    }
    

