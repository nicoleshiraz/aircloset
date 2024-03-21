//
//  StripeManager.swift
//  AirCloset
//
//  Created by cqlios3 on 20/03/24.
//

import Stripe
import Foundation

class StripeManager {
    
    private let stripeKey = "pk_test_51NmZ3OSHqyW8CqUmpkxRHYKY1J3PFxnz8RgiUKtnFir14gWiafpII3C4W4mtbcWNjHcefah4xhR3Ck4a9EJcNiHG00iVvd0Y3U"
    
    init() {
        StripeAPI.defaultPublishableKey = stripeKey
    }
    
    func createToken(cardNumber: String, expMonth: UInt, expYear: UInt, cvc: String, completion: @escaping (String?, Error?) -> Void) {
        let cardParams = STPPaymentMethodCardParams()
        cardParams.number = cardNumber
        cardParams.expMonth = NSNumber(value: expMonth)
        cardParams.expYear = NSNumber(value: expYear)
        cardParams.cvc = cvc
        
        let paymentMethodParams = STPPaymentMethodParams(card: cardParams, billingDetails: nil, metadata: [:])
        STPAPIClient.shared.createPaymentMethod(with: paymentMethodParams) { (paymentMethod, error) in
            if let error = error {
                completion(nil, error)
            } else if let paymentMethod = paymentMethod {
                completion(paymentMethod.stripeId, nil)
            }
        }
    }
}
