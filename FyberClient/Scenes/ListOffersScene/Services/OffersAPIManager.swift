//
//  OffersAPIManager.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/1/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

class OffersAPIManager: OffersStoreProtocol {
    // MARK: - Offers listing operation
    func fetchOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping (_ offers: [Offer], _ error: OffersStoreError?) -> Void) {
        let offersDataDownloader = OffersDataDownloader()
        offersDataDownloader.getOffers(userId: userId, appId: appId, securityToken: securityToken) { (offers, error)
            in
            completionHandler(offers, error)
        }
    }
}
