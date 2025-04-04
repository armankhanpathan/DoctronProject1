//
//  MyAccountViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 03/03/25.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var myProfile: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Retrieve the user data from UserDefaults
               if let fetchUserData = UserDefaults.standard.data(forKey: "userData") {
                   let decoder = JSONDecoder()
                   
                   do {
                       // Decode the user data
                       let user = try decoder.decode(UserDetail.self, from: fetchUserData)
                       
                       // Display the user data on the account page
                       usernameLabel.text = user.userName
                       emailLabel.text = user.userEmail
                       genderLabel.text = user.userGender
                   //   contactLabel.text = user.userContact
                       dobLabel.text = user.userDOB
                       
                   } catch {
                       
                       print("Error decoding user data: \(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func logOut(_ sender: UIButton) {
       
            // Remove login state from UserDefaults
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "username") // Optional: remove the username
     
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
//        self.navigationController?.pushViewController(vc, animated: true)
     //   self.navigationController?.popToRootViewController(animated: true)
        //navigationController?.popViewController(animated: true)
        
        let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        let navigation = UINavigationController(rootViewController: initialViewController)
        self.view.window?.rootViewController = navigation
        self.view.window?.makeKeyAndVisible()
        
    }
}
