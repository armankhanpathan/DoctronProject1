//
//  ResetPasswordViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 19/03/25.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    func fetchUserDetail(email: String) -> Bool {
        
        let fetchUserData = UserDefaults.standard.data(forKey: "userData")
        
        if fetchUserData != nil {
            let jsonData = fetchUserData!
            
            let decoder = JSONDecoder()
            
            do {
                let model = try decoder.decode(UserDetail.self, from: jsonData)
                print(model)
                if model.userEmail.lowercased() == email.lowercased() {
                    return true
                } else {
                    return false
                }
            } catch {
                print(error.localizedDescription)
                return false
            }
        } else {
            return false
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
      
        guard let email = emailTextField.text, !email.isEmpty else {
            showError("Please enter your email address")
            return
        }
        // Check if the email exists in the registered emails
        if fetchUserDetail(email: email) {
            // Navigate to password reset screen
            navigateToPasswordResetScreen(email: email)
        } else {
            showError("Email is not registered")
        }
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    private func navigateToPasswordResetScreen(email: String) {
        if let passwordResetVC = storyboard?.instantiateViewController(withIdentifier: "ConfirmNewPasswordViewController") as? ConfirmNewPasswordViewController {
            passwordResetVC.email = email // Pass email to the next screen
            navigationController?.pushViewController(passwordResetVC, animated: true)
        }
    }
}
