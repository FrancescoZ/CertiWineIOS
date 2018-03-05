//  LoginController
//  CertiWine
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 CertiWine.
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Moya
import SwiftKeychainWrapper
import ILLoginKit

class LoginController: LoginCoordinator {
  
  var passwordItems: [KeychainAuthenticationItem] = []
  
  // MARK: - LoginCoordinator
  
  override func start() {
    guard let retrievedPassword = KeychainWrapper.standard.string(forKey: "authCertiWine"),
          let retrivedId = KeychainWrapper.standard.string(forKey: "idUserCertiWine") else {
      super.start()
      configureAppearance()
      return
    }
    Config.Auth = retrievedPassword
    Config.ID = retrivedId
    super.finish()
    let secondViewController = self.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! UIViewController
    rootViewController?.present(secondViewController, animated: true)
  }
  
  func isAuthenticated() -> Bool{
    guard let _ = KeychainWrapper.standard.string(forKey: "authCertiWine"),
      let _ = KeychainWrapper.standard.string(forKey: "idUserCertiWine") else {
        return false
    }
    return true
  }
  
  func finish(auth: String, id: String) {
    KeychainWrapper.standard.set(auth, forKey: "authCertiWine")
    KeychainWrapper.standard.set(id, forKey: "idUserCertiWine")
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
    passwordPlaceholder = "Password"
    repeatPasswordPlaceholder = "Confirm password"
  }
  
  // MARK: - Completion Callbacks
  
  // Login
  override func login(email: String, password: String) {
    API.login(email: email, password: password, onSuccess: { auth in
      self.finish(auth: (auth as! API.Authentication).message, id: (auth as! API.Authentication).userid)
    } , onFailure: showError)
  }
  
  // Signup
  override func signup(name: String, email: String, password: String) {
    API.createUser(email: email, fullName: name, password: password, onSuccess: { auth in
      self.finish(auth: (auth as! API.Authentication).message, id: (auth as! API.Authentication).userid)
    } , onFailure: showError)
  }
  
  // Facebook
  override func enterWithFacebook(profile: FacebookProfile) {
    API.loginFacebook(email: profile.email, fullName: profile.fullName, facebookToken: profile.facebookToken, onSuccess: { auth in
      self.finish(auth: (auth as! API.Authentication).message, id: (auth as! API.Authentication).userid)
    } , onFailure: showError)
  }

  
  // Handle password recovery via your API
  override func recoverPassword(email: String) {
    //TODO Add recover Password
  }
  
  func showError(_ err:Error){
    let error = err as! API.ErrorCertiWine
    let alertController = UIAlertController(title: "Invalid Login", message: error.message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    super.navigationController.present(alertController, animated: true, completion: nil)
  }
}