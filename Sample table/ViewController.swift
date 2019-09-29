//
//  ViewController.swift
//  Dynamic table
//
//  Created by Ashok Reddy G on 28/09/19.
//  Copyright © 2019 Ashok Reddy G. All rights reserved.
//

import UIKit
//https://api.seatgeek.com/2/events?client_id=MTg2NDMxMTV8MTU2OTY4NDI4NS43OA
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
      var searchActive : Bool = false
    @IBOutlet var tableView: UITableView!
    
     var  searchEventsData:[Events]?
    
    var  eventsData:[Events]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
     
        callApi(query: "")
    
        // Do any additional setup after loading the view.
    }
    
    func callApi(query:String?)
    {
        myProgressView.shared.showProgressView(self.view)
        
        //  https://api.seatgeek.com/2/events?client_id=MTg2NDMxMTV8MTU2OTY4NDI4NS43OA&q=Texas+Ranger
        let parameter:NSMutableDictionary = NSMutableDictionary()
        NetworkServices.postApiDetails(paramValue: parameter, apiName: "https://api.seatgeek.com/2/events?client_id=MTg2NDMxMTV8MTU2OTY4NDI4NS43OA&q=\(query ?? "")", type: "GET", alertMsg: "data.."){ [weak self] (response, error) in
            DispatchQueue.main.sync
                {
                    myProgressView.shared.hideProgressView()
            }
            myProgressView.shared.hideProgressView()
            print(response as Any)
            guard let data = response else { return }
            do {
                DispatchQueue.main.sync
                    {
                        myProgressView.shared.hideProgressView()
                }
                
                let loginRespone = try JSONDecoder().decode(Responsedata.self, from: data)
                self?.eventsData = loginRespone.events
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                if(self?.searchActive ?? false){
                    self?.searchEventsData = loginRespone.events
                    
                }
                
                print(loginRespone.events?.count)
                
                for each in (loginRespone.events)!
                {
                    print(each.performers![0])
                }
                DispatchQueue.main.async
                    {
                          myProgressView.shared.hideProgressView()
                        self?.tableView.reloadData()
                        
                }
                
                
            }catch let jsonErr {
                
                DispatchQueue.main.sync
                    {
                        myProgressView.shared.hideProgressView()
                }
                
                print("Error serializing json:", jsonErr)
                myProgressView.shared.hideProgressView()
            }
            
        }
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false
        //  callsTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.reloadData()
        
        self.searchBar.showsCancelButton = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchActive = true;
        self.searchBar.showsCancelButton = true
        
        callApi(query:searchText.replacingOccurrences(of: " ", with: "+"))
     //   searchEventsData = eventsData?.filter{ ($0.title?.localizedStandardContains(searchText))! }
        
        tableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive){
            return searchEventsData?.count ?? 0
            
        }
        return  eventsData?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
         if(searchActive){
            cell.label.text =  searchEventsData?[indexPath.row].title
            cell.address.text =  searchEventsData?[indexPath.row].venue?.display_location
            cell.date.text =  searchEventsData?[indexPath.row].created_at
            
            DispatchQueue.global(qos: .background).async {
                do
                {
                    
                    if self.searchEventsData?[indexPath.row].performers![0].image != nil
                    {
                        let data = try Data.init(contentsOf: URL.init(string:((self.searchEventsData?[indexPath.row].performers![0].image)!))!)
                        
                        
                        
                        DispatchQueue.main.async {
                            let image: UIImage = UIImage(data: data)!
                            cell.displayImageView.image = image
                        }
                    }else
                    {
                        
                        if  self.searchEventsData?[indexPath.row].performers?.count ?? 0 > 1
                        {
                            if self.searchEventsData?[indexPath.row].performers?[1].image != nil
                            {
                                let data = try Data.init(contentsOf: URL.init(string:((self.searchEventsData?[indexPath.row].performers![1].image)!))!)
                                
                                
                                
                                DispatchQueue.main.async {
                                    let image: UIImage = UIImage(data: data)!
                                    cell.displayImageView.image = image
                                }
                            }
                        }
                        
                    }
                    
                }
                catch {
                    // error
                }
            }
            
              return cell
        }
        cell.label.text =  eventsData?[indexPath.row].title
         cell.address.text =  eventsData?[indexPath.row].venue?.display_location
          cell.date.text =  eventsData?[indexPath.row].created_at
         
        DispatchQueue.global(qos: .background).async {
            do
            {
                
                if self.eventsData?[indexPath.row].performers![0].image != nil
                {
                    let data = try Data.init(contentsOf: URL.init(string:((self.eventsData?[indexPath.row].performers![0].image)!))!)
                    
                    
                    
                    DispatchQueue.main.async {
                        let image: UIImage = UIImage(data: data)!
                        cell.displayImageView.image = image
                    }
                }else
                {
                    
                    if  self.eventsData?[indexPath.row].performers?.count ?? 0 > 1
                    {
                        if self.eventsData?[indexPath.row].performers?[1].image != nil
                        {
                            let data = try Data.init(contentsOf: URL.init(string:((self.eventsData?[indexPath.row].performers![1].image)!))!)
                            
                            
                            
                            DispatchQueue.main.async {
                                let image: UIImage = UIImage(data: data)!
                                cell.displayImageView.image = image
                            }
                        }
                    }
                    
                }
                
            }
            catch {
                // error
            }
        }
        return cell
        
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
         if(searchActive){
            vc.eventsData = searchEventsData![indexPath.row]
        }
       vc.eventsData =  eventsData?[indexPath.row]
         self.navigationController?.pushViewController(vc, animated: true)
        
    }


}

