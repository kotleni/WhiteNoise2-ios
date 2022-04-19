//
//  UI.swift
//  WhiteNoise
//
//  Created by Victor Varenik on 17.04.2022.
//

import UIKit

extension UIColor {
    // get uicolor for normal RGB values (0-255)
    static func fromNormalRgb(red: Int, green: Int, blue: Int, alpha: Int = 255) -> UIColor {
       return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
   }
}

extension UIView {
    // viewController
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let responder = responder as? UIViewController {
                return responder
            }
            responder = responder?.next
        }
        return nil
    }
    
    func fadeInFromLeftSide(completionAnimation: @escaping ()->() = {}) {
            let targetCenter = center
            center = CGPoint(x: 0, y: targetCenter.y)
            alpha = 0.0
            isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.center = CGPoint(x: targetCenter.x, y: targetCenter.y)
                self?.alpha = 1.0
            } completion: { isFinished in
                if isFinished {
                    completionAnimation()
                }
            }
        }
        
        func fadeOutToLeftSide(completionAnimation: @escaping ()->() = {}) {
            let targetCenter = center
            center = CGPoint(x: targetCenter.x, y: targetCenter.y)
            alpha = 1.0
            isHidden = false
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.center = CGPoint(x: 0, y: targetCenter.y)
                self?.alpha = 0.0
            } completion: { [weak self] isFinished in
                if isFinished {
                    self?.isHidden = true
                    self?.center = targetCenter
                    completionAnimation()
                }
            }
        }
}

extension UIViewController {
    func installBlurEffect() {
        let bounds = self.navigationController?.navigationBar.bounds
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.frame = bounds ?? CGRect.zero
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.navigationController?.navigationBar.addSubview(visualEffectView)
    }
}
