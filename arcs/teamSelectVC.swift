//
//  teamSelectVC.swift
//  arcs
//
//  Created by Indresh Arora on 11/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire

class teamSelectVC: UIViewController {

    @IBOutlet weak var LeaveTeamBtn: UIButton!
    @IBOutlet weak var createTeam: UIButton!
    @IBOutlet weak var joinTeamBtn: UIButton!
    @IBOutlet var createTeamBtn: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        dismissButton.layer.cornerRadius = dismissButton.frame.size.width / 2
        
        createTeam.layer.cornerRadius = 10
        createTeam.layer.borderWidth = 1.0
        createTeam.layer.borderColor = UIColor.white.cgColor
        joinTeamBtn.layer.cornerRadius = 10
        joinTeamBtn.layer.borderWidth = 1.0
        joinTeamBtn.layer.borderColor = UIColor.white.cgColor
        LeaveTeamBtn.layer.cornerRadius = 10
        LeaveTeamBtn.layer.borderWidth = 1.0
        LeaveTeamBtn.layer.borderColor = UIColor.white.cgColor

    }

    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func LeaveTeamBtnAction(_ sender: Any) {
        
        let headers: HTTPHeaders = [
            "Auth-Token": token!,
            ]
        
        Alamofire.request("https://arcs-api.herokuapp.com/api/team/leave", method:.post, headers: headers).responseJSON{ response in
            print(response.result.value)
            if let result = response.result.value as? [String:Any]{
                if result["success"] as? NSNumber == 1{
                    let alert = UIAlertController(title: "Success", message: "you have successfully left the team", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Failure", message: "please try again", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
        }
        
    }
    
    

}
