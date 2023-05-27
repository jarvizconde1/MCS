//
//  CarCollection.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/25/23.
//

import UIKit


class CarCollection: UICollectionViewCell {
    
    static let identifier = "carsCell"
    
    @IBOutlet weak var brandAndModel: UILabel!
    
    @IBOutlet weak var plate: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    var weekdate : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        getWeekDate ()
    }
    
    
    //MARK: -  get week date
    func getWeekDate () {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"

        let currentDateString: String = dateFormatter.string(from: date)
        //print("Current date is \(currentDateString)")
        weekdate = currentDateString
        
    }
    
    
    //MARK: -  SET UP
    
    func setup( car : Cars) {
        
        
        brandAndModel.text = ( (car.brand) + " " + (car.model) )
        plate.text = car.plate
        
        
        var codingDayz = ""
        
        if let lastDigitPlate  = car.plate.last {
            
            var codingDay : String {


                switch lastDigitPlate {


                case "1" : return "Monday"
                case "2" : return "Monday"

                case "3" : return "Tuesday"
                case "4" : return "Tuesday"

                case "5" : return "Wednesday"
                case "6" : return "Wednesday"

                case "7" : return "Thursday"
                case "8" : return "Thursday"

                case "9" : return "Friday"
                case "0" : return "Friday"



                default: // if x is not 0 nor 1
                   return "None"
                    
                }
                
                

            }
            
            codingDayz = codingDay
            
            
        }
            
            
                
        
        
       
        
        
        if codingDayz == weekdate {
            status.text = "Coding Today"
            status.textColor = UIColor.red
          
        }else {
            status.text = "Available"
            status.textColor = UIColor.green
            
            
        }
        
    }

}
