//
//  LoginViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/25/23.
//


import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CLTypingLabel

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var enter: CLTypingLabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var alertMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        enter.text = "Enter Login Details"
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
               
                
                if let e = error {
                    print(e)
                    print (e.localizedDescription)   //localizedDescription  = translate to device language
                    
                    self.alertMessage.text = e.localizedDescription
                    return
                    
                } else {
                    
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "loginToHome", sender: self)
                   
                   
                    
                }
                
            }
            
            
        }
        
        
    }
    
    
    //MARK: - HIDE KEYBOARD
    //extension hide keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
        // do aditional stuff
    }
}

