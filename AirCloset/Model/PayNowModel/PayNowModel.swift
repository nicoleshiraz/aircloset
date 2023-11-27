//
//  PayNowModel.swift
//  AirCloset
//
//  Created by cql200 on 12/06/23.
//

import Foundation

struct PayNowModel: Codable {
    var code: Int?
    var success: Bool?
    var message: String?
    var body: PayNowModelBody?
}

// MARK: - Body
struct PayNowModelBody: Codable {
    var id, object: String?
    var amount, amountCapturable: Int?
    var amountDetails: AmountDetails?
    var amountReceived: Int?
    var application, applicationFeeAmount, automaticPaymentMethods, canceledAt: String?
    var cancellationReason: String?
    var captureMethod, clientSecret, confirmationMethod: String?
    var created: Int?
    var currency, customer, description: String?
    var invoice, lastPaymentError, latestCharge: String?
    var livemode: Bool?
    var metadata: Metadata?
    var nextAction: NextAction?
    var onBehalfOf: String?
    var paymentMethod: String?
    var paymentMethodOptions: PaymentMethodOptions?
    var paymentMethodTypes: [String]?
    var processing, receiptEmail, review, setupFutureUsage: String?
    var shipping, source, statementDescriptor, statementDescriptorSuffix: String?
    var status: String?
    var transferData, transferGroup: String?
    var url: String?
    var productID: String?

    enum CodingKeys: String, CodingKey {
        case id, object, amount
        case amountCapturable = "amount_capturable"
        case amountDetails = "amount_details"
        case amountReceived = "amount_received"
        case application
        case applicationFeeAmount = "application_fee_amount"
        case automaticPaymentMethods = "automatic_payment_methods"
        case canceledAt = "canceled_at"
        case cancellationReason = "cancellation_reason"
        case captureMethod = "capture_method"
        case clientSecret = "client_secret"
        case confirmationMethod = "confirmation_method"
        case created, currency, customer, description, invoice
        case lastPaymentError = "last_payment_error"
        case latestCharge = "latest_charge"
        case livemode, metadata
        case nextAction = "next_action"
        case onBehalfOf = "on_behalf_of"
        case paymentMethod = "payment_method"
        case paymentMethodOptions = "payment_method_options"
        case paymentMethodTypes = "payment_method_types"
        case processing
        case receiptEmail = "receipt_email"
        case review
        case setupFutureUsage = "setup_future_usage"
        case shipping, source
        case statementDescriptor = "statement_descriptor"
        case statementDescriptorSuffix = "statement_descriptor_suffix"
        case status
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
        case url
        case productID = "productId"
    }
}

// MARK: - AmountDetails
struct AmountDetails: Codable {
    var tip: Metadata?
}

// MARK: - Metadata
struct Metadata: Codable {
}

// MARK: - NextAction
struct NextAction: Codable {
    var type: String?
    var useStripeSDK: UseStripeSDK?

    enum CodingKeys: String, CodingKey {
        case type
        case useStripeSDK = "use_stripe_sdk"
    }
}

// MARK: - UseStripeSDK
struct UseStripeSDK: Codable {
    var source: String?
    var stripeJS: String?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case source
        case stripeJS = "stripe_js"
        case type
    }
}

// MARK: - PaymentMethodOptions
struct PaymentMethodOptions: Codable {
    var card: Card?
}

// MARK: - Card
struct Card: Codable {
    var installments, mandateOptions, network: String?
    var requestThreeDSecure: String?

    enum CodingKeys: String, CodingKey {
        case installments
        case mandateOptions = "mandate_options"
        case network
        case requestThreeDSecure = "request_three_d_secure"
    }
}
