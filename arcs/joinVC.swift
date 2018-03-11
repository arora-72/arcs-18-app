//
//  joinVC.swift
//  arcs
//
//  Created by Indresh Arora on 11/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire

class joinVC: UIViewController {

    @IBOutlet weak var teamBtn: UIButton!
    @IBOutlet weak var teamIDtxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Join Team"
        teamBtn.layer.cornerRadius = 10
    }

   
    @IBAction func teamJoinAction(_ sender: Any) {
        let headers: HTTPHeaders = [
            "Auth-Token": token!,
            ]
        let parameters = [
            "team_id": teamIDtxt.text!
        ]
        Alamofire.request("https://arcs-api.herokuapp.com/api/team/join", method:.post,parameters:parameters, headers: headers).responseJSON{ response in
            print(response.result.value)
            let responseJSON = response.result.value as? [String:Any]
            if((responseJSON!["success"] as? NSNumber == 1)){
                let alert = UIAlertController(title: "Successful", message: "You have successfully joined the team", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: { action in
                    self.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)

                
            }else{
                let alert = UIAlertController(title: "Sorry", message: "Team with that name not found", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
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
