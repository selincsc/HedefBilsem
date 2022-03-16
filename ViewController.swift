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
class ViewController: MyController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource{
    var slider_array = [KingfisherSource]()
    
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        hedef_slider_list()
        hedef_collection_list()
        hedef_table_list()
    }
    @IBAction func konutestleri_button_action(_ sender: Any) {
        showVC(identifierName: "konu_testleriViewController")
    }
    @IBAction func gunluk_calisma_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController_gunlukcalisma")
    }
    @IBAction func bloglar_button_action(_ sender: Any) {
        showVC(identifierName: "bloglar_ViewController")
    }
    @IBAction func denemesinalari_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController_gunlukcalisma")
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
            collection_view_2_outlet.backgroundColor = .clear
        }
    }
    @IBOutlet weak var table_view_outlet: UITableView!{
        didSet{
            table_view_outlet.delegate = self
            table_view_outlet.dataSource = self
            table_view_outlet.rowHeight = 247
            table_view_outlet.backgroundColor = .clear
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
                collection_view_2_outlet.reloadData()
                print(" gelen data: \(hedef)")
            case .failure(let error):
                Swift.print(error)
                
            }
            
        }
    }
}
extension ViewController{
    //COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == collection_view_outlet){
            showVC(identifierName: "haf_za_ViewController")
        }
        else{
            (collectionView == collection_view_2_outlet)
                showVC(identifierName: "ViewController_gunlukcalisma")
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hedef["data"].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == collection_view_outlet){
            let cell = collection_view_outlet.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",for: indexPath) as! CollectionViewCell
            
            print("TEST")
            cell.backgroundColor = .clear
            cell.label_outlet.text = hedef["data"]["konular"][indexPath.item]["title"].stringValue
            cell.layer.cornerRadius = 12
            cell.view_outlet.backgroundColor  = .clear
            cell.view_outlet.layer.cornerRadius = 12
            return cell
        }else{
            let cell = collection_view_2_outlet.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2",for: indexPath) as! CollectionViewCell2
            cell.deneme_label_outlet.text = hedef["data"]["denemeler"][indexPath.item]["title"].stringValue
            cell.layer.cornerRadius = 12
            cell.view_outlet.layer.cornerRadius = 12
            print("bıdbııdıdbıdıd")
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180,height: 120)
    }
}
extension ViewController{
    //TABLEVIEW
    //ALAMOFIRE JSON
    func hedef_table_list(){
        let parameters : Parameters = [
            "user_id" : "2Nhbjksb7KRkl7CpHIiLGHAEM4rtOtLS",
        ]
        let url = apiURL + "/get_anasayfa"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { [self]
            response in
            
            switch response.result {
            case .success(let value):
                
                hedef = JSON(value)
                table_view_outlet.reloadData()
                print(" gelen data: \(hedef)")
            case .failure(let error):
                Swift.print(error)
            }
        }
    }
}
extension ViewController{
    func blog_id_request_json(id : String){
        let parameters : Parameters = [
            "blog_id" : id ,
        ]
        
        let url = apiURL + "/get_blog_detay"
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { [self]
            response in
            
            switch response.result {
            case .success(let value):
                
                hedef = JSON(value)
                showVC(identifierName: "blog_detayViewController")
                print("smfşöövsiv")

            case .failure(let error):
                Swift.print(error)
            }
        }
}
}
extension ViewController{
    //TABLEVIEW
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        blog_id_request_json(id: hedef["data"]["slider"][indexPath.item]["blog_id"].stringValue)
        showVC(identifierName: "blog_detayViewController")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hedef["data"].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view_outlet.dequeueReusableCell(withIdentifier: "TableViewCell",for: indexPath) as! TableViewCell
        cell.backgroundColor = .clear
        Url_To_Image(url: imageBaseURL + hedef["data"]["slider"][indexPath.item]["img_url"].stringValue, imageView: cell.image_view_outlet)
        cell.label_outlet.text = hedef["data"]["bloglar"][indexPath.item].stringValue
        cell.image_view_outlet.contentMode = .scaleToFill
        cell.view_outlet.layer.cornerRadius = 12
        cell.layer.cornerRadius = 12
        let when = DispatchTime.now() + 0.05 //Burası 0.05 sani bekletiyor.
        
        DispatchQueue.main.asyncAfter(deadline: when){
            
            DispatchQueue.main.async{ [self] in
                
                content_view_outlet.autoresizesSubviews = false //contentview autoresize false yapıyoruz ki büyütürken herşey büyümesin.
                table_view_outlet.setFrameHeight(height: table_view_outlet.contentSize.height) //tableview'i içindeki nesnelerin boyutu kadar büyütüyoruz.
                content_view_outlet.setFrameHeight(height: table_view_outlet.frame.maxY + 20) //contentviewe tableview max y + 20 kadar büyütüyoruz.
                content_view_outlet.autoresizesSubviews = true //contentview autoresize true yapıyoruz. eski haline herşey dönsün.
            }
        }
            return cell
    }
}
