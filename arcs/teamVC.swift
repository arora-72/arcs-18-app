//
//  teamVC.swift
//  arcs
//
//  Created by Indresh Arora on 11/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire

class teamVC: UIViewController,UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var submissionStatus: UILabel!
    @IBOutlet weak var teamDescription: UITextView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var gardientView: UIView!
    @IBOutlet weak var refreshBtn: UIButton!
    
    let transition = CircularTransition()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.layer.cornerRadius = menuButton.frame.size.width / 2
        refreshBtn.layer.cornerRadius = refreshBtn.frame.size.width/2
        
        
        
        //get team name
        fetchTeam()
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTeam()
        print("viewwill appear")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! UINavigationController
        secondVC.transitioningDelegate = self
        secondVC.modalPresentationStyle = .custom
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchTeam()
    }
    
    func fetchTeam(){
        let headers: HTTPHeaders = [
            "Auth-Token": token!,
            ]
        Alamofire.request("https://arcs-api.herokuapp.com/api/profile", headers: headers).responseJSON{ response in
            
            print(response.result.value)
            let responseJSON = response.result.value as? [String:Any]
            var results = responseJSON!["data"] as? [String:Any]
            
            var teamName: String?
            var submissionStatus: String?
            var teamID: String?
            var team = results!["team"] as? [String:Any]
            if (team != nil){
                            if let teamIDCheck = team!["team_id"] as? String{
                                teamID = teamIDCheck
                                self.teamDescription.text = teamIDCheck
                
                            }
                            if let teamNameCheck = team!["name"] as? String{
                                teamName = teamNameCheck
                                self.teamName.text = teamNameCheck
                            }
                            if let submissionStatusCheck = team!["submissionStatus"] as? String{
                                print(submissionStatusCheck)
                                submissionStatus = submissionStatusCheck
                                self.submissionStatus.text = submissionStatusCheck
                            }
            }else{
                self.teamDescription.text = "nil"
                self.teamName.text = "no team"
                self.submissionStatus.text = "Submission Status : 0"
            }

            
        }
        
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = menuButton.center
        transition.circleColor = menuButton.backgroundColor!
        
        return transition
    }
    

    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    @IBAction func refreshButtonAct(_ sender: Any) {
        fetchTeam()
    }
    

    

}
