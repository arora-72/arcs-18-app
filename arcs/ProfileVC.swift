//
//  ProfileVC.swift
//  arcs
//
//  Created by Indresh Arora on 10/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire


var jsonArray:NSMutableArray?

let data1 = ["Name", "Total Refreshments", "Refreshments Used","Refreshments Left"]
var nameGlobal: String?
var refreshmentsGlobal: String?
let data2 = [nameGlobal, "6", refreshmentsGlobal,refreshmentsGlobal]


class ProfileVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var indicator = UIActivityIndicatorView()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var qrcodeimage: UIImageView!
    @IBOutlet weak var qrcodeView: UIView!
    @IBOutlet weak var hackathonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        hackathonView.setGradientBackground(colorOne: UIColor.red, colorTwo: UIColor.blue)
        qrcodeView.layer.cornerRadius = 10
        qrcodeimage.layer.cornerRadius = 10
        
        //tableview
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //alamofire request
        fetchData()
        
        
    }

    
    
    //fetch data
    func fetchData(){
        self.indicator.startAnimating()
        let headers: HTTPHeaders = [
            "Auth-Token": token!,
            
        ]
        
        Alamofire.request("https://arcs-api.herokuapp.com/api/profile", headers: headers).responseJSON{ response in
            
            print(response.result.value)
            
            var name1: String?
            var refreshments1:String?
            let responseJSON = response.result.value as? [String:Any]
            var results = responseJSON!["data"] as? [String:Any]
            if let name = results!["name"] as? String{
                nameGlobal = name
            }
            if let refreshments = results!["refreshment"] as? String{
                
                refreshmentsGlobal = refreshments
            }
            
         
         
        }
        self.tableView.layer.cornerRadius = 10
        self.indicator.stopAnimating()
        self.tableView.reloadData()
    }//end function

    
    //tables
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    @IBOutlet var masterView: UIView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        cell.label1.text = data1[indexPath.row]
        print(data2)
        cell.label2.text = data2[indexPath.row]
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    private func setupActivityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        indicator.activityIndicatorViewStyle = .white
        indicator.backgroundColor = UIColor.darkGray
        indicator.center = self.view.center
        indicator.layer.cornerRadius = 05
        indicator.hidesWhenStopped = true
        indicator.layer.zPosition = 1
        indicator.isOpaque = false
        indicator.tag = 999
        self.masterView.addSubview(indicator)
    }
    
}
