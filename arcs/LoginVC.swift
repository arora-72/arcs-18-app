//
//  LoginVC.swift
//  arcs
//
//  Created by Indresh Arora on 10/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    var jsonArray: NSMutableArray?

    @IBOutlet weak var arcsImage: UIImageView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func loginBtn(_ sender: Any) {
        login()
    }
    
    func login(){
        Alamofire.request( "https://arcs-api.herokuapp.com/api/login",method:.post, parameters: ["email":self.usernameTxt.text!,"password":self.PasswordTxt.text!]).responseJSON{ response in
            print(response.response)
            print(response.request)
            print(response.data)
            print(response.result)
            
            if let contentType = response.response?.allHeaderFields["Auth-Token"] as? String {
                // use contentType here
                print(contentType)
                token = contentType
                print("token")
                print(token)
            }
            let successString: String = String(describing: response.result)
            if (successString=="SUCCESS"){
               let nextView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                self.present(nextView, animated: true, completion: nil)
            }
            
        }
    }
    
    
   
}
