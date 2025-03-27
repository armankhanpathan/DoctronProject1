//
//  SignupViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 27/02/25.
//
import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var contactNumber: String?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder() // Force keyboard to appear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.delegate = self
        birthdateTextField.delegate = self
        emailTextField.delegate = self
        genderTextField.delegate = self
        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    // Function to validate all fields are filled
    func areFieldsFilled() -> Bool {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            showAlert(message: "Name is required.")
            return false
        } else if birthdateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            showAlert(message: "Birthdate is required.")
            return false
        } else if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            showAlert(message: "Email is required.")
            return false
        } else if genderTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            showAlert(message: "Gender is required.")
            return false
        } else if passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true {
            showAlert(message: "Password is required.")
            return false
        }
        return true
    }

    // Function to show an alert with a specific message
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Missing Information", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // Function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        birthdateTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        genderTextField.resignFirstResponder() // Hide keyboard
        passwordTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        // Validate all required fields before proceeding
        if areFieldsFilled() {
            if isValidEmail(emailTextField.text!) {
                
        // If all fields are filled and email is valid
                let dataStore = UserDetail(id: 11, userName: nameTextField.text!, userDOB: birthdateTextField.text!, userGender: genderTextField.text!, userEmail: emailTextField.text!, userPassword: passwordTextField.text!)
                
                // Data passig to storeUserData global variable
                storeUserData = dataStore
                
                let jsonEncoder = JSONEncoder()
                do {
                    let jsonResultData = try jsonEncoder.encode(dataStore)
                    UserDefaults.standard.setValue(jsonResultData, forKey: "userData")
                } catch {
                    print("Error encoding data: \(error)")
                }
                
                // Navigate to the success screen after successful signup
                _ = self.storyboard?.instantiateViewController(withIdentifier: "RegisterdSuccessfulViewController") as! RegisterdSuccessfulViewController
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                // Show alert if email is invalid
                showAlert(message: "Please enter a valid email address.")
            }
        }
    }
}
