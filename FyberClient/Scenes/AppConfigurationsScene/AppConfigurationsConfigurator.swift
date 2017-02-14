//
//  AppConfigurationsConfigurator.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/13/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

extension AppConfigurationsViewController: AppConfigurationsPresenterOutput {

}

extension AppConfigurationsInteractor: AppConfigurationsViewControllerOutput {
    
}

extension AppConfigurationsPresenter: AppConfigurationsInteractorOutput {
    
}

class AppConfigurationsConfigurator {
    
    static let sharedInstance = AppConfigurationsConfigurator()
    
    private init() {}
    
    func configure(viewController: AppConfigurationsViewController) {
        let router = AppConfigurationsRouter()
        router.viewController = viewController
        
        let presenter = AppConfigurationsPresenter()
        presenter.output = viewController
        
        let interactor = AppConfigurationsInteractor()
        interactor.output = presenter
        
        viewController.output = interactor
        viewController.router = router
    }
    
    func configureNavigationBarTintColor(viewController: UIViewController, tintColor: UIColor?) {
        viewController.navigationController?.navigationBar.barTintColor = tintColor
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configureViewControllerBackgroundColor(viewController: UIViewController, backgroundColor: UIColor?) {
        viewController.view.backgroundColor = backgroundColor
    }
}
