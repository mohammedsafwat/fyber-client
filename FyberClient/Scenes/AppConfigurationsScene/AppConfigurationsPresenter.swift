//
//  AppConfigurationsPresenter.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/14/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

protocol AppConfigurationsPresenterInput {
    func presentConfigurationInputsVerification(_ response: AppConfigurations.VerifyConfigurationInputs.Response)
}

protocol AppConfigurationsPresenterOutput: class {
    func displayAppConfigurationsVerificationResult(_ viewModel: AppConfigurations.VerifyConfigurationInputs.ViewModel)
}

class AppConfigurationsPresenter: AppConfigurationsPresenterInput {
    weak var output: AppConfigurationsPresenterOutput!
    
    func presentConfigurationInputsVerification(_ response: AppConfigurations.VerifyConfigurationInputs.Response) {
        var displayedError: AppConfigurations.VerifyConfigurationInputs.ViewModel.DisplayedError?
        var configurationInputsVerificationResult: AppConfigurations.VerifyConfigurationInputs.ViewModel.ConfigurationInputsVerificationResult?
        
        if response.verified {
            displayedError = nil
            configurationInputsVerificationResult = AppConfigurations.VerifyConfigurationInputs.ViewModel.ConfigurationInputsVerificationResult(verified: true)
        } else {
            displayedError = AppConfigurations.VerifyConfigurationInputs.ViewModel.DisplayedError(errorTitle: "Error", errorMessage: "Please make sure that all configuration inputs are filled.")
            configurationInputsVerificationResult = AppConfigurations.VerifyConfigurationInputs.ViewModel.ConfigurationInputsVerificationResult(verified: false)
        }
        
        
        let viewModel = AppConfigurations.VerifyConfigurationInputs.ViewModel(displayedError: displayedError, configurationInputsVerificationResult: configurationInputsVerificationResult)
        output.displayAppConfigurationsVerificationResult(viewModel)
    }
}
