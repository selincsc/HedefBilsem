//
//  konu_testleriViewController.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class konu_testleriViewController: MyController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        konutestleri_collection_list()
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var collection_view_outlet: UICollectionView!{
        didSet{
            collection_view_outlet.dataSource = self
            collection_view_outlet.delegate = self
            collection_view_outlet.backgroundColor  = .clear
        }
    }
    
    @IBOutlet weak var content_view_outlet: UIImageView!
}
extension konu_testleriViewController{
    //COLLECTIONVIEW
    //ALAMOFIRE JSON
    func konutestleri_collection_list(){
        let parameters : Parameters = [:
            
        ]
        let url = apiURL + "/get_konu_test"
        
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
extension konu_testleriViewController{
    //COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hedef["data"].count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collection_view_outlet.dequeueReusableCell(withReuseIdentifier: "konu_testleriCollectionViewCell",for: indexPath) as! konu_testleriCollectionViewCell
            
            print("TEST")
            cell.backgroundColor = .clear
            cell.label_outlet.text = hedef["data"][indexPath.item]["title"].stringValue
            cell.layer.cornerRadius = 12
            let when = DispatchTime.now() + 0.05 //Burası 0.05 sani bekletiyor.
        
        DispatchQueue.main.asyncAfter(deadline: when){
            
            DispatchQueue.main.async{ [self] in
                
                content_view_outlet.autoresizesSubviews = false //contentview autoresize false yapıyoruz ki büyütürken herşey büyümesin.
                collection_view_outlet.setFrameHeight(height: collection_view_outlet.contentSize.height) //tableview'i içindeki nesnelerin boyutu kadar büyütüyoruz.
                collection_view_outlet.setFrameHeight(height: collection_view_outlet.frame.maxY + 20) //contentviewe tableview max y + 20 kadar büyütüyoruz.
                content_view_outlet.autoresizesSubviews = true //contentview autoresize true yapıyoruz. eski haline herşey dönsün.
            }
        }
        
       
            return cell
        }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 180,height: 230)
}
}


