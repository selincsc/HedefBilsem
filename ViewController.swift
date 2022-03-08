//
//  ViewController.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 8.03.2022.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import ImageSlideshow
class ViewController: MyController {
    var slider_array = [KingfisherSource]()
    override func viewDidLoad() {
        super.viewDidLoad()
        hedef_slider_list()
    }

    @IBOutlet weak var image_view_outlet: AnimatedImageView!
    @IBOutlet var content_view_outlet: UIView!
    @IBOutlet weak var header_view_outlet:UIView!{
        didSet{
            header_view_outlet.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var slider_view_outlet: ImageSlideshow!
    @IBOutlet weak var collection_view_outlet: UICollectionView!{
        
    }
}

extension ViewController{
    //SLİDER
    //ALAMOFIRE JSON
    func hedef_slider_list(){
        let parameters : Parameters = [
            "user_id" : "2Nhbjksb7KRkl7CpHIiLGHAEM4rtOtLS",
        ]
        let url = apiURL + "/get_anasayfa"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { [self]
            response in
            
            switch response.result {
            case .success(let value):
                
                hedef = JSON(value)
                print(" gelen data: \(hedef)")
                for slider in hedef["data"]["slider"]{
                            slider_array.append(KingfisherSource(urlString: imageBaseURL + slider.1["img_url"].stringValue)!)
                        }
                        
                        request_sliderView(imageSlide: slider_view_outlet, KingfisherArray: slider_array)
            case .failure(let error):
                Swift.print(error)
            }
        }
    }
}
