//
//  mainPageVC.swift
//  arcs
//
//  Created by Indresh Arora on 10/03/18.
//  Copyright © 2018 Indresh Arora. All rights reserved.
//

import UIKit

class mainPageVC: UIViewController {

    @IBOutlet weak var hackathonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hackathonView.setGradientBackground(colorOne: UIColor.red, colorTwo: UIColor.yellow)
        
        
        //not working
        //   hackathonView.layer.cornerRadius = 1000
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
