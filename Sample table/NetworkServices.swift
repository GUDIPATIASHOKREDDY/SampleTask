

import Foundation
import UIKit
class NetworkServices:NSObject{
    

    class func postApiDetails(paramValue : Any,apiName:String,type:String,alertMsg:String,completion: @escaping (Data?, Error?)->Void) {
        
        
        if #available(iOS 10.0, *) {
         
          

        guard let url = NSURL(string:apiName) else {
            print("Error: cannot create URL")
            return
        }
           // print(url)
        
            let defaultSession = URLSession.shared
            var request = URLRequest(url: url as URL)
            
        
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
                request.httpMethod = type
            
            if(type == "POST")
            {
                        do {
                            request.httpBody = try JSONSerialization.data(withJSONObject: paramValue, options: .prettyPrinted)                         } catch let error {
                            print(error.localizedDescription)
                        }
            }

        let task = defaultSession.dataTask(with: request as URLRequest, completionHandler: { data, response, error in


            guard error == nil else {

                completion(nil, error)


                return
            }

            guard let data = data else {

                completion(nil, error)
                return
            }

            do {
                //create json object from data
                
                 completion(data, nil)

            }
            
            catch {
                
              
            }
            
        })
        task.resume()
        } else {
            // Fallback on earlier versions
        }
}
    
}


open class myProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var label = UILabel()
    open class var shared: myProgressView {
        struct Static {
            static let instance: myProgressView = myProgressView()
        }
        return Static.instance
    }
    
    open func showProgressView(_ view: UIView) {
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
        containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.1)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x:  containerView.bounds.width / 2, y:  containerView.bounds.height / 2-100)
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView() {
        
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
    open func showProgressView1(_ view: UIView) {
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/2)
        containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        progressView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        progressView.center = CGPoint(x:  containerView.bounds.width / 2, y:  containerView.bounds.height / 2)
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .whiteLarge
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    open func hideProgressView1() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
