//
//  createVC.swift
//  arcs
//
//  Created by Indresh Arora on 11/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire



class createVC: UIViewController {
    
    @IBOutlet weak var createTeamBtn: UIButton!
    
    @IBOutlet weak var createTeamTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Create Team"
        // Do any additional setup after loading the view.
        createTeamBtn.layer.cornerRadius = 10
        
        
    }
    
    
    @IBAction func createTeamBtnAction(_ sender: Any) {
        createTeam()
    }
    
    
    
    func createTeam(){
        let headers:HTTPHeaders = [
            "Auth-Token":token!
        ]
        let paramerters = [
            "teamName": createTeamTxt.text!
        ]
        
//        Alamofire.request("https://arcs-api-.herokuapp.com/api/team/create",headers: headers,paramerter: paramerters )
        
        print(createTeamTxt.text)
        Alamofire.request("https://arcs-api.herokuapp.com/api/team/create",method:.post, parameters: paramerters, headers: headers).responseJSON{ response in
//            print(response.response)
//            print(response.request)
//            print(response.result.value)
            
            let responseJSON = response.result.value as? [String:Any]
            print("responseJSON")
            print(responseJSON!["success"])
            var results = responseJSON!["data"] as? [String:Any]
            if ((responseJSON!["success"] as? NSNumber) == 0){
                let alert = UIAlertController(title: "Sorry", message: "Team with that name is already made", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                self.present(alert, animated: true, completion: nil)

                
            }else if((responseJSON!["success"] as? NSNumber) == 1){
                var results = responseJSON!["data"] as? [String:Any]
                if let teamID = results!["team_id"] as? String{
                    teamIDG = teamID
                }
                let alert = UIAlertController(title: "Succesful", message: "You have successfully created your team", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
