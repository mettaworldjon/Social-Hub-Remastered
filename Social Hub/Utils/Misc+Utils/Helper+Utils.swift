//
//  Helper+Utils.swift
//  Social Hub
//
//  Created by Jonathan Dowdell on 1/25/19.
//  Copyright © 2019 Jonathan Dowdell. All rights reserved.
//

import UIKit
import Lottie

// StackView Quick Add
extension UIStackView {
    func addViewsToStack(_ viewArray:[UIView]) {
        for view in viewArray {
            self.addArrangedSubview(view)
        }
    }
}

extension String {
    func validText() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func validEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func validPassword() -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?,.;@]).*$")
        return passwordTest.evaluate(with:self)
    }
}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.clear
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
    func enableUI(_ view:UIView, _ btn:UIButton?, _ text:String?, _ value:Bool,completionBlock: (() -> ())? = nil) {
        if value {
            UIViewController.removeSpinner(spinner: view)
            btn?.setTitle("Login", for: .normal)
            UIApplication.shared.endIgnoringInteractionEvents()
        } else {
            UIViewController.removeSpinner(spinner: view)
            btn?.setTitle("Login", for: .normal)
            self.completeLoginSignUp(250, 0) {
                guard let completion = completionBlock else {return}
                completion()
            }
        }
    }
    
    func completeLoginSignUp( _ height:CGFloat, _ offset:CGFloat,completionBlock: (() -> ())? = nil) {
        let animationView = LOTAnimationView(name: "complete")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.layer.cornerRadius = 10
        animationView.alpha = 0
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        self.view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            animationView.heightAnchor.constraint(equalToConstant: height)
            ])
        animationView.play { (_) in
            UIView.animate(withDuration: 0.5, delay: 1, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                animationView.alpha = 0
                animationView.layoutIfNeeded()
            }, completion: { (_) in
                guard let completion = completionBlock else {return}
                completion()
            })
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            animationView.alpha = 1
            animationView.layoutIfNeeded()
        }, completion: nil)
    }
}


extension UINavigationController {
    func rootViewController() -> UIViewController {
        return self.navigationController?.viewControllers.first ?? UIViewController()
    }
}

