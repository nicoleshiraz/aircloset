// MARK: Reference Guide for Apple Login
// https://developer.apple.com/documentation/authenticationservices/implementing_user_authentication_with_sign_in_with_apple



import Foundation
import AuthenticationServices
import LocalAuthentication

class AppleLoginManager: NSObject{
    static let shared = AppleLoginManager()
    private override init() {}
    
    typealias COMPLETION_HANDLER = (AppleModel)->Void
    var completionHandler: COMPLETION_HANDLER?
    
    func setup(_ completion: @escaping COMPLETION_HANDLER) {
        self.completionHandler = completion
        self.handleAppleIdRequest()
    }
    
}

extension AppleLoginManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    @objc func handleAppleIdRequest() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            
            let model = AppleModel()
            model.handleData(appleCredential: appleIDCredential)
            if self.completionHandler != nil {
                self.completionHandler!(model)
            }
            
//            // Check Credential State
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            appleIDProvider.getCredentialState(forUserID: appleIDCredential.user) {  (credentialState, error) in
//                 switch credentialState {
//                    case .authorized:
//                        // The Apple ID credential is valid.
//
//
//
//                        break
//                    case .revoked:
//                        // The Apple ID credential is revoked.
//                        AlertManager.shared.show(GPAlert(title: "Apple Sign-in", message: "Apple ID credential is revoked."))
//                        break
//                    case .notFound:
//                        // No credential was found, so show the sign-in UI.
//                    AlertManager.shared.show(GPAlert(title: "Apple Sign-in", message: "Apple ID credential not found."))
//                    default:
//                        break
//                 }
//            }
        }
    }
        
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        if let topController = UIApplication.topViewController() {
//            return topController.view.window!
//        }
//        
        return UIApplication.shared.windows.first!
    }
}

                
// MARK:- Fetch User Information from Apple


class AppleModel{
    var token, name, firstName, lastName, id, email, picture: String!
    
    @available(iOS 13.0, *)
    func handleData(appleCredential: ASAuthorizationAppleIDCredential) {
        if let identityTokenData = appleCredential.identityToken,
            let identityTokenString = String(data: identityTokenData, encoding: .utf8) {
            self.token = identityTokenString
            
            if let currentUserIdentifier: String = KeychainItem.currentUserIdentifier{
                if currentUserIdentifier == appleCredential.user {
                    self.id = currentUserIdentifier
                }else{
                    self.id = appleCredential.user
                }
            }else{
                KeychainItem.currentUserIdentifier = appleCredential.user
                self.id = appleCredential.user
            }
            
            
            if appleCredential.fullName?.familyName == nil{
                self.lastName = KeychainItem.currentUserLastName
            }else{
                KeychainItem.currentUserLastName = appleCredential.fullName?.familyName
                self.lastName = appleCredential.fullName?.familyName
                }
            }
            if appleCredential.fullName?.givenName == nil{
                self.firstName = KeychainItem.currentUserFirstName
                }else{
                    KeychainItem.currentUserFirstName = appleCredential.fullName?.givenName
                    self.firstName = appleCredential.fullName?.givenName
                }
            
            if appleCredential.email == nil{
                self.email = KeychainItem.currentUserEmail
                }else{
                    KeychainItem.currentUserEmail = appleCredential.email
                self.email = appleCredential.email
                }
            self.name = "\(self.firstName ?? "") \(self.lastName ?? "")"
        }
    }

