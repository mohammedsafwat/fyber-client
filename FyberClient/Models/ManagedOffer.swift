//
//  ManagedOffer.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/30/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import Foundation
import CoreData

class ManagedOffer: NSManagedObject {
    func toOffer() -> Offer {
        return Offer(offerTitle: offerTitle, offerID: offerID, offerTeaser: offerTeaser, offerAction: offerAction, offerLowResolutionThumbnailURL: offerLowResolutionThumbnailURL, offerHighResolutionThmbnailURL: offerLowResolutionThumbnailURL, offerPayoutAmount: offerPayoutAmount)
    }
}
