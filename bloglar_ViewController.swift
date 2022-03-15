//
//  bloglar_ViewController.swift
//  HedefBilsem
//
//  Created by Selin Çağlar on 15.03.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class bloglar_ViewController: MyController, UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        bloglar_table_list()
    }
    @IBOutlet var content_view_outlet: UIView!
    @IBOutlet weak var table_view_outlet: UITableView!{
        didSet{
            table_view_outlet.delegate = self
            table_view_outlet.dataSource = self
            table_view_outlet.rowHeight = 220
            table_view_outlet.backgroundColor = .clear
        }
    }
    @IBAction func back_button_action(_ sender: Any) {
        showVC(identifierName: "ViewController")
    }
}
extension bloglar_ViewController{
    //TABLEVIEW
    //ALAMOFIRE JSON
    func bloglar_table_list(){
        let parameters : Parameters = [
            "start" : "0",
            "end" : "10",

        ]
        let url = apiURL + "/get_bloglar"
        
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
extension bloglar_ViewController{
    //TABLEVIEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hedef["data"].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table_view_outlet.dequeueReusableCell(withIdentifier: "bloglar_TableViewCell",for: indexPath) as! bloglar_TableViewCell
        cell.backgroundColor = .clear
        Url_To_Image(url: imageBaseURL + hedef["data"][indexPath.item]["img_url"].stringValue, imageView: cell.image_view_outlet)
        cell.image_view_outlet.contentMode = .scaleToFill
        cell.label_outlet.text  = hedef["data"][indexPath.item]["title"].stringValue
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

