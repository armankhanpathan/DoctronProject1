//
//  TabBarViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 03/03/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    var isFromBooking = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if isFromBooking {
            self.selectedIndex = 1
        }
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
}
