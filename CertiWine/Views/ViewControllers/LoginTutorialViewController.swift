//  LoginTutorialViewController
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

import UIKit

class LoginTutorialViewController: UIViewController {

    @IBOutlet weak var skipButton: UIButton!
    lazy var loginController = LoginController(rootViewController: self)
  
    override func viewDidLoad() {
        super.viewDidLoad()
      if !loginController.authenticate(){
        setupPaperOnboardingView()
        view.bringSubview(toFront: skipButton)
      }
  }
  
  @IBAction func skipButtonTouch() {
    loginController.start()
  }
  
  private func setupPaperOnboardingView() {
      let onboarding = PaperOnboarding()
      onboarding.delegate = self
      onboarding.dataSource = self
      onboarding.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(onboarding)
      
      // Add constraints
      for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
        let constraint = NSLayoutConstraint(item: onboarding,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 0)
        view.addConstraint(constraint)
      }
    }

}

extension LoginTutorialViewController : PaperOnboardingDataSource {
  
  func onboardingItem(at index: Int) -> OnboardingItemInfo {
    
    let retVal = [OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "cover-vertical"),
                                     title: "Phase 1",
                                     description: "Setup your preferences",
                                     pageIcon: #imageLiteral(resourceName: "circle-medium"),
                                     color: Color.Background,
                                     titleColor: Color.Title,
                                     descriptionColor: Color.Description,
                                     titleFont: Font.montserratRegular.get(size: 30),
                                     descriptionFont: Font.montserratRegular.get(size: 13)),
                  OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "cover-vertical"),
                                     title: "Phase 2",
                                     description: "Decide your random comment to use in the process",
                                     pageIcon:#imageLiteral(resourceName: "circle-medium"),
                                     color: Color.Background,
                                     titleColor: Color.Title,
                                     descriptionColor: Color.Description,
                                     titleFont: Font.montserratRegular.get(size: 30),
                                     descriptionFont: Font.montserratRegular.get(size: 13)),
                  
                  OnboardingItemInfo(informationImage: #imageLiteral(resourceName: "cover-vertical"),
                                     title: "Work",
                                     description: "Swipe and comment",
                                     pageIcon: #imageLiteral(resourceName: "circle-medium"),
                                     color: Color.Background,
                                     titleColor: Color.Title,
                                     descriptionColor: Color.Description,
                                     titleFont: Font.montserratRegular.get(size: 30),
                                     descriptionFont: Font.montserratRegular.get(size: 13))]
                
    return retVal[index]
  }
  
  func onboardingItemsCount() -> Int {
    return 3
  }
}

extension LoginTutorialViewController : PaperOnboardingDelegate {
  func onboardingWillTransitonToIndex(_ index: Int) {
    skipButton.setTitle("Skip...", for: .normal)
    if index == 2{
      skipButton.setTitle("Login...", for: .normal)
    }
  }
  
  func onboardingDidTransitonToIndex(_: Int) {
  }
  
  func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
  }
}


