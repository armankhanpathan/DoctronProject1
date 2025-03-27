//
//  HomeScreenViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 27/02/25.
//

import UIKit

        // Login Screen

class HomeScreenViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var wrongPasswordLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        usernameTextField.becomeFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
            if self.navigationController == nil {
                print("No Navigation Controller")
            } else {
                print("Navigation Controller is set up")
            }
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        wrongPasswordLabel.isHidden = true
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Check if the user is already logged in
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            // The user is logged in, navigate directly to the home screen
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
           self.navigationController?.pushViewController(vc, animated: false)
           vc.modalPresentationStyle = .fullScreen
           self.present(vc, animated: true)
        
        }
    }
    
    // Example Login Function (without backend)
    func authenticateUser() -> Bool {
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
        let fetchUserData = UserDefaults.standard.data(forKey: "userData")
        
        if fetchUserData != nil {
            let jsonData = fetchUserData!
            
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode(UserDetail.self, from: jsonData)
                print(model)
                storeUserData = model
            } catch {
                print(error.localizedDescription)
            }
            
            if (username == storeUserData?.userEmail) && password == storeUserData?.userPassword {
                // Successful login
                // handleLoginSuccess()
                return true
            } else {
                // Failed login
                // handleLoginFailure()
                return false
            }
        } else {
            return false
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        // Check if either the username or password field is empty
        if usernameTextField.text?.isEmpty ?? true {
            // If the username is empty, show a message asking for email or phone number
            wrongPasswordLabel.isHidden = false
            wrongPasswordLabel.text = "Please enter email or phone number"
            
        } else if passwordTextField.text?.isEmpty ?? true {
            // If the password is empty, show a message asking for password
            wrongPasswordLabel.isHidden = false
            wrongPasswordLabel.text = "Please enter your password"
            
        } else {
            // If both fields are not empty, attempt to authenticate
            if authenticateUser() {
                // Save the login state to UserDefaults
                UserDefaults.standard.set(true, forKey: "isLoggedIn") // Flag indicating that the user is logged in
                UserDefaults.standard.set(usernameTextField.text, forKey: "username") // Save username (optional)

                // If authentication is successful, navigate to the next screen
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                // after login it must be root view controller
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                // If authentication fails, show the "Wrong password" label
                wrongPasswordLabel.isHidden = false
                wrongPasswordLabel.text = "Wrong username or password"
            }
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func resetPassword(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
