//
//  UIAlertsHelper.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/4/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

class UIAlertsHelper {
    static let sharedInstance = UIAlertsHelper()
    
    // MARK: - Displaying alerts
    func displayAlert(viewController: UIViewController, alertTitle: String?, alertMessage: String?) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
