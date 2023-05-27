//
//  RegisterViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CLTypingLabel
class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var enter: CLTypingLabel!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var PasswordText: UITextField!
    
    @IBOutlet weak var warningMessage: UILabel!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        enter.text = "Enter Your Details Below"
        
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func registerButton(_ sender: Any) {
        if let email = emailText.text , let password = PasswordText.text , let name = nameText.text {
            
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let e = error {
                    print (e.localizedDescription)
                    //localizedDescription  = translate to device language
                    
                    self.warningMessage.text = e.localizedDescription
                    
                    return
                }
                else {
                    
                    
                    
                    
                    var ref: DocumentReference? = nil
                    ref = self.db.collection("user").addDocument(data: [
                        
                        
                        "email" : email,
                        "name": name,
                        
                        
                        
                    ]) { err in
                        if let err = err {
                            self.warningMessage.text = err.localizedDescription
                            print("Error adding user: \(err)")
                        } else {
                            print("USER ADDED : \(ref!.documentID)")
                            
                            //CLEARS THE TEXT FIELD
                            self.emailText.text = ""
                            self.PasswordText.text = ""
                            self.nameText.text = ""
                            
                            self.performSegue(withIdentifier: "registerToHome", sender: self)
                        }
                    }
                    
                    
                    
                    
                    
                    
                    
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
