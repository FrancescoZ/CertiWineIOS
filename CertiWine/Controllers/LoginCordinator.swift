//
//  LoginCordinator.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import ILLoginKit
import Moya

class LoginCoordinator: ILLoginKit.LoginCoordinator {
  
  // MARK: - LoginCoordinator
  
  override func start() {
    super.start()
    configureAppearance()
  }
  
  override func finish() {
    super.finish()
  }
  
  // MARK: - Setup
  
  // Customize LoginKit. All properties have defaults, only set the ones you want.
  func configureAppearance() {
    // Customize the look with background & logo images
    //backgroundImage = 
    // mainLogoImage =
    // secondaryLogoImage =
    
    // Change colors
    tintColor = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1)
    errorTintColor = UIColor(red: 253.0/255.0, green: 227.0/255.0, blue: 167.0/255.0, alpha: 1)
    
    // Change placeholder & button texts, useful for different marketing style or language.
    loginButtonText = "Sign In"
    signupButtonText = "Create Account"
    facebookButtonText = "Login with Facebook"
    forgotPasswordButtonText = "Forgot password?"
    shouldShowForgotPassword = false
    recoverPasswordButtonText = "Recover"
    namePlaceholder = "Name"
    emailPlaceholder = "E-Mail"
    passwordPlaceholder = "Password!"
    repeatPasswordPlaceholder = "Confirm password"
    
    
  }
  
  // MARK: - Completion Callbacks
  
  // Login
  override func login(email: String, password: String) {
    let provider = MoyaProvider<UserAPI>()
    provider.request(.login(email: email, passwrd: password)) { result in
      switch result {
      case let .success(response):
        switch response.statusCode{
        case 200:
        return //TODO redirect
        default:
          var message = ""
          do{
            let json = try response.map(<#T##type: Decodable.Protocol##Decodable.Protocol#>, atKeyPath: <#T##String?#>, using: <#T##JSONDecoder#>) mapObjectOptional()
            message = ""
          } catch _ {
            message = "Check your network and try again"
          }
          
          let alertController = UIAlertController(title: "Invalid Login", message: message, preferredStyle: UIAlertControllerStyle.alert)
          alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
          
          super.navigationController.present(alertController, animated: true, completion: nil)
          break
        }
      default:
        //TODO Manage exception
        break
      }
      
    }
  }
  
  // Signup
  override func signup(name: String, email: String, password: String) {
    let provider = MoyaProvider<UserAPI>()
    provider.request(.createUser(email: email, name: name, passwrd: password, passwrdConfirmation: password )){ result in
      switch result {
      case let .success(moyaResponse):
        switch moyaResponse.statusCode{
        case 200:
        return //TODO redirect
        default:
          //TODO Manage exception
          break
        }
      default:
        //TODO Manage exception
        break
      }
    }
  }
  
  // Facebook
  override func enterWithFacebook(profile: FacebookProfile) {
    let provider = MoyaProvider<UserAPI>()
    provider.request(.loginFacebook(email: profile.email, token: profile.facebookToken)) { result in
      switch result {
      case let .success(moyaResponse):
        switch moyaResponse.statusCode{
        case 200:
          return //TODO redirect
        default:
          //TODO Manage exception
          break
        }
      default:
        //TODO Manage exception
        break
      }
      provider.request(.createUserFacebook(email: profile.email, name: profile.fullName, token: profile.facebookToken)){ result in
        switch result {
        case let .success(moyaResponse):
          switch moyaResponse.statusCode{
          case 200:
            return //TODO redirect
          default:
            //TODO Manage exception
            break
          }
          default:
            //TODO Manage exception
            break
        }
      }
    }
  }

  
  // Handle password recovery via your API
  override func recoverPassword(email: String) {
    //TODO Add recover Password
  }
  
}
