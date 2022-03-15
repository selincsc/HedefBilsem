//
//  ViewController_gunlukcalisma.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController_gunlukcalisma: MyController, UICollectionViewDataSource, UICollectionViewDelegate {
   

    override func viewDidLoad() {
        super.viewDidLoad()
        gunlukcalisma_collection_list()

       
    }
    
    @IBOutlet weak var collection_view_outlet: UICollectionView!{
        didSet{
            collection_view_outlet.dataSource = self
            collection_view_outlet.delegate = self
            collection_view_outlet.backgroundColor = .clear
        }
    }
}
extension ViewController_gunlukcalisma{
    //COLLECTIONVIEW
    //ALAMOFIRE JSON
    func gunlukcalisma_collection_list(){
        let parameters : Parameters = [
            "start" : "0",
            "end" : "10",

        ]
        let url = apiURL + "/get_gunluk_test"
        
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
extension ViewController_gunlukcalisma{
        //COLLECTIONVIEW
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return hedef["data"].count
        }
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collection_view_outlet.dequeueReusableCell(withReuseIdentifier: "gunlukcalisma_CollectionViewCell",for: indexPath) as! gunlukcalisma_CollectionViewCell
                
                print("TEST")
                cell.backgroundColor = .clear
                cell.aylar_label_outlet.text = "fvfmlvöşsfd"
                cell.haftalar_label_outlet.text = "cfv.fv"
                cell.tarih_label_outlet.text = "v fv fv "
                
                return cell
            }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180,height: 120)
    }
        }

