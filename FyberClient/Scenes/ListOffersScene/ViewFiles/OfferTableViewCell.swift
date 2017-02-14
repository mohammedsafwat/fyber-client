//
//  OfferTableViewCell.swift
//  FyberClient
//
//  Created by Mohammed Safwat on 1/31/17.
//  Copyright © 2017 Mohammed Safwat. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var offerTitleLabel: UILabel!
    @IBOutlet weak var offerTeaserLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var offerPayoutIconImageView: UIImageView!
    @IBOutlet weak var offerPayoutAmountLabel: UILabel!
    @IBOutlet weak var parentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = Constants.OffersListTableView.tableViewCellParentViewBackgroundColor
        selectionStyle = .none

        parentView.layer.cornerRadius = 4
        parentView.layer.masksToBounds = true
        parentView.layer.borderColor = UIColor.white.cgColor
        offerImageView.layer.cornerRadius = 4
        offerImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
