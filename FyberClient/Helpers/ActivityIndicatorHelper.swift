//
//  ActivityIndicatorHelper.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/30/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ActivityIndicatorHelper: NSObject {
    static let sharedInstance = ActivityIndicatorHelper()
    
    // MARK: - Display activity indicator
    func displayActivityIndicator() {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopActivityIndicator() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
