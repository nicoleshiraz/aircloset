//
//  ReviewTVCell.swift
//  AirCloset
//
//  Created by cql105 on 18/04/23.
//

import UIKit
import Cosmos

class ReviewTVCell: UITableViewCell {

    @IBOutlet weak var productImage: CustomImageView!
    @IBOutlet weak var userImage: CustomImageView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(reviewData: ReviewModelBody) {
        userImage.imageLoad(imageUrl: "\(imageURL)\(reviewData.userID?.image ?? "")")
        usernameLbl.text = reviewData.productID?.categoryID?.name?.capitalizeFirstLetter() ?? ""
        ratingView.rating = Double(reviewData.rating ?? 0)
        ratingView.text = "\(reviewData.rating ?? 0)"
        ratingView.isUserInteractionEnabled = false
        productImage.imageLoad(imageUrl: "\(productImageUrl)\(reviewData.productID?.image?.first ?? "")")
        descriptionLbl.text = reviewData.message ?? ""
    }
    
    func setDataNew(reviewData: SignleProductReviewBody) {
        userImage.imageLoad(imageUrl: "\(imageURL)\(reviewData.userID?.image ?? "")")
        usernameLbl.text = reviewData.userID?.name?.capitalizeFirstLetter()
        ratingView.rating = Double(reviewData.rating ?? 0)
        ratingView.text = "\(reviewData.rating ?? 0)"
        ratingView.isUserInteractionEnabled = false
        productImage.imageLoad(imageUrl: "\(productImageUrl)\(reviewData.productID?.image?.first ?? "")")
        descriptionLbl.text = reviewData.message ?? ""
    }
    
}
