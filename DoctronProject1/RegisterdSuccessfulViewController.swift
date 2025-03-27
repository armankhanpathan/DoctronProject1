//
//  RegisterdSuccessfulViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 07/03/25.
//

import UIKit

class RegisterdSuccessfulViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backToLogibBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
