//
//  AddCarsViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth



class AddCarsViewController: UIViewController  {

    @IBOutlet weak var brand: UITextField!
    
    
    
    @IBOutlet weak var model: UITextField!
    
    
    @IBOutlet weak var plate: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func save(_ sender: Any) {
        if let carBrand = brand.text , let carModel = model.text, let carPlate = plate.text , let email = Auth.auth().currentUser?.email {
            
            // Add a new document with a generated ID
            var ref: DocumentReference? = nil
           
            ref = db.collection("cars").addDocument(data: [
                "Owner": email,
                "Brand": carBrand,
                "Model": carModel,
                "Plate": carPlate
                
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document saved! : \(ref!.documentID)")
                    
                    self.brand.text = ""
                    self.plate.text = ""
                    self.model.text = ""
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        self.tabBarController?.selectedIndex = 0
                    }
                    
                }
            }
            
            
        }
            
        
        
        
        
    }
   
    

}
