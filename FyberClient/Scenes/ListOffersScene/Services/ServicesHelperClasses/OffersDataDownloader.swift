//
//  OffersDataDownloader.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 2/1/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit
import CryptoSwift

class OffersDataDownloader {
    
    // MARK: - Network requests to Fyber API
    func getOffers(userId: String?, appId: String?, securityToken: String?, _ completionHandler: @escaping (_ offers: [Offer], _ error: OffersStoreError?) -> Void) {
    
        
        if let userId = userId, let appId = appId, let securityToken = securityToken {
            // Create URL and request
            let session = URLSession.shared
            
            var parametersString = Constants.FyberOffersAPISettings.parametersString.replacingOccurrences(of: "[APP_ID]", with: appId)
            parametersString = parametersString.replacingOccurrences(of: "[FORMAT]", with: Constants.FyberOffersAPISettings.format)
            parametersString = parametersString.replacingOccurrences(of: "[IP_ADDRESS]", with: Constants.FyberOffersAPISettings.ipAddress)
            parametersString = parametersString.replacingOccurrences(of: "[LOCALE]", with: Constants.FyberOffersAPISettings.locale)
            parametersString = parametersString.replacingOccurrences(of: "[OFFER_TYPES]", with: Constants.FyberOffersAPISettings.offerTypes)
            parametersString = parametersString.replacingOccurrences(of: "[UNIX_TIMESTAMP]", with: String(NSDate().timeIntervalSince1970))
            parametersString = parametersString.replacingOccurrences(of: "[USER_ID]", with: userId)
            
            let hashkey = (parametersString + "&" + securityToken).sha1()
            
            var urlString = Constants.FyberOffersAPISettings.baseUrl.replacingOccurrences(of: "[PARAMETERS_STRING]", with: parametersString)
            urlString = urlString.replacingOccurrences(of: "[HASH_KEY]", with: hashkey)
            
            guard let url = URL(string: urlString) else {
                fatalError("Error creating a URL from the urlString provided for Fyber Offers API.")
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = Constants.FyberOffersAPISettings.requestType
            
            // Create network request
            let task = session.dataTask(with: request) {
                (data, response, error)
                in
                
                // GUARD: Check that the data received has not been corrupted
                guard let signature = (response as? HTTPURLResponse)?.allHeaderFields["X-Sponsorpay-Response-Signature"] else {
                    print("It seems that the data is corrupted. No signature header was returned with the response.")
                    let error = OffersStoreError.cannotFetch(errorMessage: "Unfortunately, the returned data is corrupted. Please try to send the request one more time.")
                    return completionHandler([], error)
                }
                
                // GUARD: Check that the value of the signature is not nil
                guard ((signature as? String) != nil) else {
                    print("It seems that the value for the signature is nil.")
                    let error = OffersStoreError.cannotFetch(errorMessage: "Unfortunately, the returned data is corrupted. Please try to send the request one more time.")
                    return completionHandler([], error)
                }
                
                // GUARD: Was there an error?
                guard (error == nil) else {
                    print("An error happened with this request: \(request) ")
                    let error = OffersStoreError.cannotFetch(errorMessage: "An error happened with this request: \(request) ")
                    return completionHandler([], error)
                }
                
                
                
                // GUARD: Did we get a successful 2x response code?
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
                    statusCode >= 200 && statusCode <= 299 else {
                        print("The request: \(request) returned a status other than 2xx!")
                        let error = OffersStoreError.cannotFetch(errorMessage: "The request: \(request) returned a status other than 2xx!")
                        return completionHandler([], error)
                }
                
                // GUARD: Was there any data returned?
                guard let data = data else {
                    print("No data was returned by the request!")
                    let error = OffersStoreError.cannotFetch(errorMessage: "No data was returned by the request!")
                    return completionHandler([], error)
                }
                
                // Parse the data
                let parsedResult: [String:AnyObject]!
                do {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                } catch {
                    print("Could not parse the data as JSON: '\(data)'")
                    let error = OffersStoreError.cannotFetch(errorMessage: "Could not parse the data as JSON: '\(data)'")
                    return completionHandler([], error)
                }
                
                // GUARD: Check if the keys are correctly returned with the response
                guard let offersArray = parsedResult[Constants.FyberOffersAPIResponseKeys.offers] as? [[String:AnyObject]] else {
                    print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offers) in \(parsedResult)")
                    let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offers) in \(parsedResult)")
                    return completionHandler([], error)
                }
                
                var offers: [Offer] = []
                
                for offerDictionary in offersArray {
                    // Offer Title
                    guard let offerTitle = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerTitle] as? String else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerTitle) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerTitle) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer ID
                    guard let offerID = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerID] as? Int else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerID) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerID) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer Teaser
                    guard let offerTeaser = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerTeaser] as? String else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerTeaser) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerTeaser) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer Thumbnail
                    guard let offerThumbnailDictionary = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerThumbnail] as? [String:String] else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerThumbnail) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerThumbnail) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer Low Resolution Thumbnail URL
                    guard let offerLowResolutionThumbnailURL = offerThumbnailDictionary[Constants.FyberOffersAPIResponseKeys.offerLowResolutionThumbnail] as String! else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerLowResolutionThumbnail) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerLowResolutionThumbnail) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer High Resolution Thumbnail URL
                    guard let offerHighResolutionThumbnailURL = offerThumbnailDictionary[Constants.FyberOffersAPIResponseKeys.offerHighResolutionThmbnail] as String! else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerHighResolutionThmbnail) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerHighResolutionThmbnail) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer Payout
                    guard let offerPayoutAmount = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerPayout] as? Int else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerPayout) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerPayout) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    // Offer Action
                    guard let offerAction = offerDictionary[Constants.FyberOffersAPIResponseKeys.offerAction] as? String else {
                        print("Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerAction) in \(parsedResult)")
                        let error = OffersStoreError.cannotFetch(errorMessage: "Cannot find key \(Constants.FyberOffersAPIResponseKeys.offerAction) in \(parsedResult)")
                        return completionHandler([], error)
                    }
                    
                    let offer = Offer(offerTitle: offerTitle, offerID: offerID, offerTeaser: offerTeaser, offerAction: offerAction, offerLowResolutionThumbnailURL: offerLowResolutionThumbnailURL, offerHighResolutionThmbnailURL: offerHighResolutionThumbnailURL, offerPayoutAmount: offerPayoutAmount)
                    
                    offers.append(offer)
                }
                completionHandler(offers, nil)
            }
            
            // Start the task
            task.resume()
        } else {
            let error = OffersStoreError.cannotFetch(errorMessage: "Error. It seems that either userId, appId or securityToken value is nil.")
            completionHandler([], error)
        }
    }
}
