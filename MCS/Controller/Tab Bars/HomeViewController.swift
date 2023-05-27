//
//  HomeViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class HomeViewController: UIViewController    {
    

    @IBOutlet weak var carCollectionView: UICollectionView!
    
   
    let db = Firestore.firestore()
    let userEmail = Auth.auth().currentUser?.email
    
    var carArray : [Cars] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      loadCars()
        
        
        //register a custom cell
        
        carCollectionView.register(UINib(nibName: "CarCollection" , bundle: nil ),  forCellWithReuseIdentifier: CarCollection.identifier )
        
        
        
    }
    
   
   
    
    //MARK: - load cars from user
    
    func loadCars(){
        
        // Create a reference to the cities collection
        let carsRef = db.collection("cars")

        // Create a query against the collection. where field
        let carCollection = carsRef.whereField("Owner", isEqualTo: userEmail!)
        
        //clearing the existing array , so its empty when a new car is retrieved after saving
        self.carArray = []
        
        carCollection.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in querySnapshot!.documents {
                    
                    let data = doc.data()

                    if let carBrand = data["Brand"] as? String , let carPlate = data["Plate"] as? String, let carModel = data["Model"] as? String {

                        let newCar = Cars( documentId: doc.documentID , brand: carBrand, model: carModel, plate: carPlate)

                        self.carArray.append(newCar)
                        
                        //print(newCar)
                       
                    }
                   



                    DispatchQueue.main.async {

                        self.carCollectionView.reloadData()

                    }


                }
            }
        }
        
        
    }
    
    
    @IBAction func logoutButton(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            
            
            view.window!.rootViewController?.dismiss(animated: true, completion: nil)
           
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return self.carArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // use your custom cell design
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarCollection.identifier , for: indexPath) as! CarCollection
        
        
        
        cell.setup(car: carArray[indexPath.row])
        
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let pressedCar = carArray[indexPath.row]
        
        performSegue(withIdentifier: "goToDetails", sender: pressedCar )
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       
        guard let selectedCar = sender as? Cars else {
            return
        }
        
        if segue.identifier == "goToDetails"{
            
            guard let destinatonVC = segue.destination as? DetailsViewController else {
                return
            }
            
            //do something if the segue is dismissed
            destinatonVC.onDoneBlock = { result in
                // Do something
                self.loadCars()
             }
            destinatonVC.selectedCarToDisplay = selectedCar
                    
        }
    }
    
    
}

