//
//  Constants.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/30/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit
import AdSupport

struct Constants {
    static let lightGrayColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    
    // MARK: - Fyber Offers API Settings
    struct FyberOffersAPISettings {
        static let parametersString = "appid=[APP_ID]&format=[FORMAT]&ip=[IP_ADDRESS]&locale=[LOCALE]&offer_types=[OFFER_TYPES]&timestamp=[UNIX_TIMESTAMP]&uid=[USER_ID]"
        static let baseUrl = "http://api.fyber.com/feed/v1/offers.json?[PARAMETERS_STRING]" + "&hashkey=[HASH_KEY]"
        static let format = "json"
        static let ipAddress = "109.235.143.113"
        static let locale = "de"
        static let offerTypes = "112"
        static let requestType = "GET"
        //2070
        var appId: String?
        //"spiderman"
        var userId: String?
        //"1c915e3b5d42d05136185030892fbb846c278927"
        var token: String?
    }
    
    // MARK: - Fyber Offers API Response Keys
    struct FyberOffersAPIResponseKeys {
        static let offers = "offers"
        static let offerTitle = "title"
        static let offerID = "offer_id"
        static let offerTeaser = "teaser"
        static let offerAction = "required_actions"
        static let offerLink = "link"
        static let offerThumbnail = "thumbnail"
        static let offerLowResolutionThumbnail = "lowres"
        static let offerHighResolutionThmbnail = "hires"
        static let offerPayout = "payout"
    }
    
    // MARK: - ViewControllers Titles
    struct ViewControllersTitles {
        static let listOffersViewControllerTitle = "Offers"
        static let listOffersTableViewCellName = "OfferTableViewCell"
        static let listOffersTableViewCellIdentifier = "OfferTableViewCell"
    }
    
    // MARK: - Offers List TableView Properties
    struct OffersListTableView {
        static let cellHeight = CGFloat(124.0)
        static let tableViewBackgroundColor = lightGrayColor
        static let tableViewCellParentViewBackgroundColor = lightGrayColor
    }
    
    // MARK: - List Offers View Controller Navigation Bar Properties
    struct ListOffersNavigationBarProperties {
        static let navigationBarTintColor = lightGrayColor
    }
    
    // MARK: - List Offers View Controller Segues Identifiers
    struct ListOffersViewControllerSegues {
        static let appConfigurationsToListOffersViewControllerIdentifier = "ListOffersViewControllerSegue"
    }
}
