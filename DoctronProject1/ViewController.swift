//
//  ViewController.swift
//  DoctronProject1
//
//  Created by Web Bunny Mac on 26/02/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contactText: UITextField!
    
    var contactNumber: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let contact = contactNumber {
            contactText.text = contact // Display the contact number or use it as needed
               }
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
        // Ensure the contactText field is not empty
        if let contact = contactText.text, contact.isEmpty {
            
            // Show an alert if the field is empty
            let alert = UIAlertController(title: "Field Required", message: "Please enter a contact number or email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if let contact = contactText.text, !isValidContact(contact) {
            
            // Show an alert if the contact number is not valid (not 10 digits or not a number)
            let alert = UIAlertController(title: "Invalid Contact", message: "Please enter a valid 10-digit contact number.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
            // Now navigate to the SignupViewController
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
            vc.contactNumber = contactText.text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Function to validate contact number
    func isValidContact(_ contact: String) -> Bool {
        
        // Regular expression to match a 10-digit number
        let regex = "^[0-9]{10}$" // Matches exactly 10 digits
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        return test.evaluate(with: contact)
    }
