//
//  AppConfigurationsModels.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/13/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

struct AppConfigurations {
    struct VerifyConfigurationInputs {
        struct Request {
            var appId: String?
            var userId: String?
            var securityToken: String?
        }
        
        struct Response {
            var verified: Bool
        }
        
        struct ViewModel {
            struct ConfigurationInputsVerificationResult {
                var verified: Bool
            }
            
            struct DisplayedError {
                var errorTitle: String?
                var errorMessage: String?
            }
            var displayedError: DisplayedError?
            var configurationInputsVerificationResult: ConfigurationInputsVerificationResult?
        }
    }
}
