//
//  ManagedOffer+CoreDataProperties.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/30/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import Foundation

extension ManagedOffer {
    @NSManaged var offerTitle: String?
    @NSManaged var offerID: Int
    @NSManaged var offerTeaser: String?
    @NSManaged var offerAction: String?
    @NSManaged var offerLowResolutionThumbnailURL: String?
    @NSManaged var offerHighResolutionThmbnailURL: String?
    @NSManaged var offerPayoutAmount: Int
}
