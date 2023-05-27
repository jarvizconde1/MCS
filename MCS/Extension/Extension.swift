//
//  Extension.swift
//  MCS
//
//  Created by Jarvis Vizconde on 5/27/23.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardOnTap(_ selector: Selector) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}


//usage

//Swift 3:
//
//Extension with Selector as parameter to be able to do additional stuff in the dismiss function and cancelsTouchesInView to prevent distortion with touches on other elements of the view.
//
//extension UIViewController {
//    func hideKeyboardOnTap(_ selector: Selector) {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//}
//Usage:
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
//}
//
//func dismissKeyboard() {
//    view.endEditing(true)
//    // do aditional stuff
//}
