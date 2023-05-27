//
//  InitialPageViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/26/23.
//

import UIKit
import CLTypingLabel

class InitialPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        manila.text = "Manila"
        coding.text = "Coding"
        scheme.text = "Scheme"
        
    }
    

    @IBOutlet weak var manila: CLTypingLabel!
    
    @IBOutlet weak var coding: CLTypingLabel!
    @IBOutlet weak var scheme: CLTypingLabel!
    
}
