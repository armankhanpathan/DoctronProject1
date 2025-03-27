//
//  ConfirmNewPasswordViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 19/03/25.
//

import UIKit

class ConfirmNewPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var email: String? // Receive the email passed from the previous screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
    }
    
    @IBAction func resetPasswordButtonTapped(_ sender: UIButton) {
        
        guard let newPassword = newPasswordTextField.text, !newPassword.isEmpty else {
            showError("Please enter a new password")
            return
        }
        
        guard let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showError("Please confirm your new password")
            return
        }
        
        // Check if new password and confirmation password match
        if newPassword != confirmPassword {
            showError("Passwords do not match")
            return
        }
        
        // Update password in UserDefaults
        if let email = email {
            updatePassword(email: email, newPassword: newPassword)
        }
    }
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    private func updatePassword(email: String, newPassword: String) {
        // Fetch the stored user data from UserDefaults
        let fetchUserData = UserDefaults.standard.data(forKey: "userData")
        
        if let jsonData = fetchUserData {
            let decoder = JSONDecoder()
            
            do {
                var userDetail = try decoder.decode(UserDetail.self, from: jsonData)
                
                // Check if the email matches the stored user email
                if userDetail.userEmail.lowercased() == email.lowercased() {
                    // Update the password
                    userDetail.userPassword = newPassword
                    
                    // Encode the updated user data back to UserDefaults
                    let encoder = JSONEncoder()
                    let updatedData = try encoder.encode(userDetail)
                    UserDefaults.standard.set(updatedData, forKey: "userData")
                    
                    // Success: Show confirmation and navigate back to login screen
                    showSuccess("Password updated successfully")
                    
                } else {
                    showError("User not found")
                }
                
            } catch {
                print(error.localizedDescription)
                showError("Failed to update password")
            }
        } else {
            showError("No user data found")
        }
    }
    
    private func showSuccess(_ message: String) {
        // Show success message
        errorLabel.text = message
        errorLabel.textColor = .green
        errorLabel.isHidden = false
        
        // Optionally, navigate back to the login screen after success
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
