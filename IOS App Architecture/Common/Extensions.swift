//
//  Extensions.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 16/06/2023.
//

import UIKit
import Toast

extension UIStoryboard {
    
    static func auth() -> UIStoryboard {
        UIStoryboard(name: "Auth", bundle: .main)
    }
    
    static func profile() -> UIStoryboard {
        UIStoryboard(name: "Profile", bundle: .main)
    }
    
    static func domain() -> UIStoryboard {
        UIStoryboard(name: "Domain", bundle: .main)
    }
}

extension UIView {
    func show(message: String) {
        makeToast(message)
    }
}

extension UILabel {
    
    @discardableResult
    func text(_ text: String) -> UILabel {
        self.text = text
        return self
    }
    
    @discardableResult
    func textColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> UILabel {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
}

extension UIColor {
        
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    func darkened() -> UIColor {
        var h = CGFloat(0), s = CGFloat(0), b = CGFloat(0), a = CGFloat(0), w = CGFloat(0);
        if(getHue(&h, saturation: &s, brightness: &b, alpha: &a)) {
            return UIColor(hue: h, saturation: s, brightness: (b*0.70), alpha: a);
        } else if(getWhite(&w, alpha: &a)) {
            return UIColor(white: w, alpha: a);
        }
        return UIColor.clear;
    }
    
    static func random() -> UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func createImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.setFillColor(self.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}

extension UIScrollView {
    
    func addSpinner(target: Any, action: Selector, color: UIColor? = nil) {
        refreshControl = UIRefreshControl()
        if let color = color {
            refreshControl?.tintColor = color
        }
        refreshControl?.addTarget(target, action: action, for: .valueChanged)
    }
    
    func showSpinner() {
        setContentOffset(CGPoint(x: 0, y: -100), animated: true)
        refreshControl?.beginRefreshing()
    }
    
    func hideSpinner() {
        refreshControl?.endRefreshing()
    }
}
