//
//  AppConfigurationsInteractor.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/14/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

protocol AppConfigurationsInteractorInput {
    func verifyAppConfigurationsInputs(_ request: AppConfigurations.VerifyConfigurationInputs.Request)
}

protocol AppConfigurationsInteractorOutput {
    func presentConfigurationInputsVerification(_ response: AppConfigurations.VerifyConfigurationInputs.Response)
}

class AppConfigurationsInteractor: AppConfigurationsInteractorInput {
    var output: AppConfigurationsInteractorOutput!
    
    func verifyAppConfigurationsInputs(_ request: AppConfigurations.VerifyConfigurationInputs.Request) {
        var verified: Bool = false
        if let appId = request.appId, let userId = request.userId, let securityToken = request.securityToken {
            if appId.isNotEmpty && userId.isNotEmpty && securityToken.isNotEmpty {
                verified = true
            }
        }
        let response = AppConfigurations.VerifyConfigurationInputs.Response(verified: verified)
        output.presentConfigurationInputsVerification(response)
    }
}
