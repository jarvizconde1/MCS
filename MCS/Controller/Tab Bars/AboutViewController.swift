//
//  AboutViewController.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/26/23.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://www.moneymax.ph/car-insurance/articles/number-coding-philippines") else {return}
        
        webViews.load(URLRequest(url: url))
        
        
        
    }
    
    @IBOutlet weak var webViews: WKWebView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webViews.frame = view.bounds
    }
    

   

}
