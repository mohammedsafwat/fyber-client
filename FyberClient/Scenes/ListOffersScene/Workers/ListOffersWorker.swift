//
//  ListOffersWorker.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/28/17.
//  Copyright (c) 2017 Mohammed Safwat. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

class ListOffersWorker {
    var offersStore: OffersStoreProtocol

    init(offersStore: OffersStoreProtocol) {
        self.offersStore = offersStore
    }

    func fetchOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping (_ offers: [Offer], _ error: OffersStoreError?) -> Void) {
        offersStore.fetchOffers(userId: userId, appId: appId, securityToken: securityToken) { (offers : [Offer], error: OffersStoreError?)
            in
            DispatchQueue.main.async {
                completionHandler(offers, error)
            }
        }
    }
}

// MARK: - Offers store API
protocol OffersStoreProtocol {
    // MARK: - Offers listing operation
    func fetchOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping (_ offers: [Offer], _ error: OffersStoreError?) -> Void)
}

// MARK: - Offers store operation results
enum OffersStoreResult<U> {
    case success(result: U)
    case failure(error: OffersStoreError)
}

// MARK: - Offers store operation errors
enum OffersStoreError: Error {
    case cannotFetch(errorMessage: String)
}
