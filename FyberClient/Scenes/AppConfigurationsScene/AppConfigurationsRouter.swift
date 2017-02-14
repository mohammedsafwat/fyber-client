//
//  AppConfigurationsRouter.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/13/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

protocol AppConfigurationsRouterInput {
    
}

class AppConfigurationsRouter {
    weak var viewController: AppConfigurationsViewController!
    
    // MARK: - Navigation    
    func passDataToNextScene(_ segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ListOffersViewControllerSegues.appConfigurationsToListOffersViewControllerIdentifier {
            let listOffersViewController = segue.destination as? ListOffersViewController
            let appConfigurationsViewController = sender as? AppConfigurationsViewController
            
            listOffersViewController?.appId = appConfigurationsViewController?.appId
            listOffersViewController?.userId = appConfigurationsViewController?.userId
            listOffersViewController?.securityToken = appConfigurationsViewController?.securityToken
        }
    }
}
