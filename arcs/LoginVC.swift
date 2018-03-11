//
//  LoginVC.swift
//  arcs
//
//  Created by Indresh Arora on 10/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {
    var jsonArray: NSMutableArray?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var arcsImage: UIImageView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var PasswordTxt: UITextField!
    
    
    @IBOutlet weak var loginBtnT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       loginBtnT.layer.cornerRadius = 20.0
    }
    
    
    func startAnimatingIndicator(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
    func stopAnimatingIndicator(){
        dismiss(animated: true, completion: nil
        )
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        subscribeToKeyboardNotifications()
//    }
    

    @IBAction func loginBtn(_ sender: Any) {
        login()
    }
    
    func login(){
        startAnimatingIndicator()
        Alamofire.request( "https://arcs-api.herokuapp.com/api/login",method:.post, parameters: ["email":self.usernameTxt.text!,"password":self.PasswordTxt.text!]).responseJSON{ response in
//            print(response.response)
//            print(response.request)
//            print(response.data)
//            print(response.result)
            print(response.result.value)
            
                let responseJSON = response.result.value as? [String:Any]
            if (responseJSON!["success"] as? NSNumber) == 0{
                self.stopAnimatingIndicator()
                let alertController = UIAlertController(title: "Sorry", message: responseJSON!["message"] as? String, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: { action in
                    self.stopAnimatingIndicator()
                })
                alertController.addAction(ok)
                self.present(alertController, animated: true, completion: nil)
            }else{
                if let contentType = response.response?.allHeaderFields["Auth-Token"] as? String {
                    // use contentType here
                    print(contentType)
                    token = contentType
                    print("token")
                    print(token)
                }
                let successString: String = String(describing: response.result)
                self.stopAnimatingIndicator()
                if (successString=="SUCCESS"){
                    let nextView = self.storyboard?.instantiateViewController(withIdentifier: "tabBarVC") as! UITabBarController
                    self.present(nextView, animated: true, completion: nil)
                }else if(successString=="FAILURE"){
                    let alertController = UIAlertController(title: "Sorry", message: "Please check your internet connection", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil)
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
    }
    
   

    
    
    
   
}
}


