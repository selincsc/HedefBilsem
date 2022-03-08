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
class ViewController: MyController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
var slider_array = [KingfisherSource]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        hedef_slider_list()
        hedef_collection_list()
    }

    @IBOutlet weak var image_view_outlet: AnimatedImageView!
    @IBOutlet var content_view_outlet: UIView!
    @IBOutlet weak var header_view_outlet:UIView!{
        didSet{
            header_view_outlet.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var slider_view_outlet: ImageSlideshow!{
        didSet{
            slider_view_outlet.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var collection_view_outlet: UICollectionView!{
        didSet{
            collection_view_outlet.delegate = self
            collection_view_outlet.dataSource = self
            collection_view_outlet.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var collection_view_2_outlet: UICollectionView!{
        didSet{
            collection_view_2_outlet.dataSource = self
            collection_view_2_outlet.delegate = self
        }
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
extension ViewController{
    //COLLECTIONVIEW
    //ALAMOFIRE JSON
    func hedef_collection_list(){
        let parameters : Parameters = [
            "user_id" : "2Nhbjksb7KRkl7CpHIiLGHAEM4rtOtLS",
        ]
        let url = apiURL + "/get_anasayfa"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { [self]
            response in
            
            switch response.result {
            case .success(let value):
                
                hedef = JSON(value)
                collection_view_outlet.reloadData()
                print(" gelen data: \(hedef)")
            case .failure(let error):
                Swift.print(error)
            }
        }
    }
}
extension ViewController{
    //COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hedef["data"].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection_view_outlet.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",for: indexPath) as! CollectionViewCell
        
        print("TEST")
        
        cell.backgroundColor = .clear
        cell.label_outlet.text = hedef["data"]["konular"][indexPath.item]["title"].stringValue
        cell.layer.cornerRadius = 12
        cell.view_outlet.backgroundColor  = .clear
        cell.view_outlet.layer.cornerRadius = 12
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180,height: 120)
    }
}
 
