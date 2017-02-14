//
//  AppConfigurationsViewController.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/13/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit
import TextFieldEffects

protocol AppConfigurationsViewControllerInput {
    func displayAppConfigurationsVerificationResult(_ viewModel: AppConfigurations.VerifyConfigurationInputs.ViewModel)
}

protocol AppConfigurationsViewControllerOutput {
    func verifyAppConfigurationsInputs(_ request: AppConfigurations.VerifyConfigurationInputs.Request)
}

class AppConfigurationsViewController: UIViewController, AppConfigurationsViewControllerInput, UITextFieldDelegate {
    
    var output: AppConfigurationsViewControllerOutput!
    var router: AppConfigurationsRouter!
    
    var appId: String?
    var userId: String?
    var securityToken:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppConfigurationsConfigurator.sharedInstance.configure(viewController: self)
        AppConfigurationsConfigurator.sharedInstance.configureNavigationBarTintColor(viewController: self, tintColor: Constants.ListOffersNavigationBarProperties.navigationBarTintColor)
        AppConfigurationsConfigurator.sharedInstance.configureViewControllerBackgroundColor(viewController: self, backgroundColor: Constants.OffersListTableView.tableViewBackgroundColor)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Text Fields
    
    @IBOutlet weak var applicationIDTextField: HoshiTextField!
    @IBOutlet weak var userIDTextField: HoshiTextField!
    @IBOutlet weak var securityTokenTextField: HoshiTextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        populateConfigurationValuesFromInputs(textField)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        populateConfigurationValuesFromInputs(textField)
    }
    
    func populateConfigurationValuesFromInputs(_ textField: UITextField) {
        textField.resignFirstResponder()
        if let textFieldInput = textField.text {
            switch textField {
            case applicationIDTextField:
                appId = textFieldInput
            case userIDTextField:
                userId = textFieldInput
            case securityTokenTextField:
                securityToken = textFieldInput
            default:
                appId = ""
                userId = ""
                securityToken = ""
            }
        }
    }
    
    @IBAction func fetchOffersButtonTapped(_ sender: Any) {
        let request = AppConfigurations.VerifyConfigurationInputs.Request(appId: applicationIDTextField.text, userId: userIDTextField.text, securityToken: securityTokenTextField.text)
        output.verifyAppConfigurationsInputs(request)
    }
    
    func displayAppConfigurationsVerificationResult(_ viewModel: AppConfigurations.VerifyConfigurationInputs.ViewModel) {
        let displayedError = viewModel.displayedError
        let configurationInputsVerificationResult = viewModel.configurationInputsVerificationResult
                
        if configurationInputsVerificationResult?.verified == false {
            UIAlertsHelper.sharedInstance.displayAlert(viewController: self, alertTitle: displayedError?.errorTitle, alertMessage: displayedError?.errorMessage)
        } else {
            self.performSegue(withIdentifier: Constants.ListOffersViewControllerSegues.appConfigurationsToListOffersViewControllerIdentifier, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue, sender: sender)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
