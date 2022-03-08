//
//  MyController.swift
//  app5-windows
//
//  Created by Selin Çağlar on 27.01.2022.
//

import UIKit
import Kingfisher
import ImageSlideshow

class MyController: UIViewController {
    
    func request_sliderView(imageSlide : ImageSlideshow, KingfisherArray : [KingfisherSource]){

           imageSlide.slideshowInterval = 5.0
           imageSlide.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
           
           let pageControl = UIPageControl()
           pageControl.currentPageIndicatorTintColor = UIColor.lightGray
           pageControl.pageIndicatorTintColor = UIColor.black
           imageSlide.pageIndicator = pageControl
           
           // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
           imageSlide.activityIndicator = DefaultActivityIndicator()
           
           // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
           imageSlide.setImageInputs(KingfisherArray)

           imageSlide.contentScaleMode = UIViewContentMode.scaleAspectFill
       }


    func Url_To_Image(url : String , imageView : AnimatedImageView, contentScaleMode : UIView.ContentMode =                 UIView.ContentMode.scaleAspectFit){
            
            imageView.contentMode = contentScaleMode
            let url = URL(string: url)
            imageView.kf.setImage(with: url)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showVC(identifierName: String, StoryBoardName : String  = "Main", animated : Bool = true, presentationStyle : Bool = true ) {
        
        let newViewController = UIStoryboard(name: StoryBoardName, bundle: nil).instantiateViewController(withIdentifier: identifierName)
        // MARK: V0.0.4 EKLENDİ
        if presentationStyle {
            newViewController.modalPresentationStyle = .fullScreen
        }
        
        UIApplication.topViewController()?.present(newViewController, animated: animated, completion: nil)
        
    }
    
    func messageBox(title: String, message: String, buttonTitle : String = "Tamam" , identifierName: String = "", StoryBoardName : String  = "Main" , animated : Bool = true, isDismiss : Bool = false){
        
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action: UIAlertAction!) in
            
            if isDismiss == true{
                self.dismiss(animated: false)
            }else if(identifierName != ""){
                self.showVC(identifierName: identifierName, StoryBoardName: StoryBoardName, animated: animated)
            }
            
        }))
        UIApplication.topViewController()?.present(refreshAlert, animated: true, completion: nil)
    }
    
   
}

extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}


// MARK: V0.0.3 Eklendi
extension String {
    var toUTF8: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}
