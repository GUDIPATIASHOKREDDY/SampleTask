//
//  DetailViewController.swift
//  Dynamic table
//
//  Created by Ashok Reddy G on 29/09/19.
//  Copyright © 2019 Ashok Reddy G. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var details: UITextView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var favorite: UIButton!
    
      var  eventsData:Events?
    @IBOutlet var back: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  =  eventsData?.title
      
        details.text = "\(String(describing: (eventsData?.created_at)!)) \n \(String(describing: (eventsData?.venue?.display_location)!)) "
//        cell.address.text = eventsData.venue?.display_location
//        cell.date.text =  eventsData.created_at

        DispatchQueue.global(qos: .background).async {
            do
            {
                
                if self.eventsData?.performers![0].image != nil
                {
                    let data = try Data.init(contentsOf: URL.init(string:((self.eventsData?.performers![0].image)!))!)
                    
                    
                    
                    DispatchQueue.main.async {
                        let image: UIImage = UIImage(data: data)!
                        self.imageView.image = image
                    }
                }else
                {
                    
                    if self.eventsData?.performers?.count ?? 0 > 1
                    {
                        if self.eventsData?.performers?[1].image != nil
                        {
                            let data = try Data.init(contentsOf: URL.init(string:((self.eventsData?.performers![1].image)!))!)
                            
                            
                            
                            DispatchQueue.main.async {
                                let image: UIImage = UIImage(data: data)!
                                self.imageView.image = image
                            }
                        }
                    }
                    
                }
                
            }
            catch {
                // error
            }
        }
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
