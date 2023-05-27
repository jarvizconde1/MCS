//
//  DetailsViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/26/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class DetailsViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var brand: UITextField!
    @IBOutlet weak var model: UITextField!
    @IBOutlet weak var plate: UITextField!
    
    
    var onDoneBlock : ((Bool) -> Void)?
    
    let db = Firestore.firestore()
    
    let userEmail = Auth.auth().currentUser?.email
    
    var selectedCarToDisplay : Cars?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        brand.text = selectedCarToDisplay?.brand
        model.text = selectedCarToDisplay?.model
        plate.text = selectedCarToDisplay?.plate
        
        
        
    }
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        // Update one field, creating the document if it does not exist.
        
        if let newName = brand.text , let newPlate = plate.text ,  let newModel = model.text {
            db.collection("cars").document((selectedCarToDisplay?.documentId)! ).setData([
                "Brand": newName,
                "Plate":newPlate,
                "Model": newModel,
                 ], merge: true)  { err in
                if let err = err {
                    print("Error saving document: \(err)")
                } else {
                    self.dismiss(animated: true) {
                        self.onDoneBlock!(true)
                    }
                }
            }
        }
        
    }
    
    
    
    
    
    @IBAction func deleteButton(_ sender: Any) {
        
        db.collection("cars").document((selectedCarToDisplay?.documentId)! ).delete()  { err in
            if let err = err {
                print("Error deleting document: \(err)")
            } else {
                self.dismiss(animated: true) {
                    self.onDoneBlock!(true)
                }
            }
        }
        
    }
    
}
