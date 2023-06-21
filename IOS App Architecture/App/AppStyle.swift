import UIKit

class AppStyle {
    
    // MARK: - Fonts
    
    static let light = Font(name: "SFProText-Light")
    static let normal = Font(name: "SFProText-Regular")
    static let semibold = Font(name: "SFProText-Semibold")
    static let bold = Font(name: "SFProText-Bold")
    static let accent = Font(name: "Poppins-Regular")
    
    // MARK: - Colors
    static let primary = UIColor(hexString: "#A62648")
    static let background = UIColor(hexString: "#F6F5F1")
    static let textColor = UIColor(hexString: "#171717")
    
    // MARK: - Other styles
    
    static let cornerRadius: CGFloat = 8.0
    
    // Add other styles as needed
    static func getAttributedString(_ text: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        let string = NSMutableAttributedString(string: text)
        string.addAttribute(.foregroundColor, value: color,
                             range: NSRange(location: 0, length: string.length))
        string.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.length))
        return string
    }
}

class Font {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func font(_ size: CGFloat) -> UIFont {
        return UIFont(name: name, size: size)!
    }
    
    func label(_ size: CGFloat) -> UILabel {
        return UILabel().font(font(size))
    }
}

class CustomInsetField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+16, y: bounds.origin.y, width: bounds.width-32, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+16, y: bounds.origin.y, width: bounds.width-32, height: bounds.height)
    }
}


class PrimaryButton: UIButton {
    
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? AppStyle.primary : UIColor(hexString: "#cc8e9c")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.font(AppStyle.bold.font(20))
        setTitleColor(.white, for: .normal)
        tintColor = .white
        layer.cornerRadius = 8
        self.isEnabled = isEnabled
    }
}

class LinkButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel?.font(AppStyle.normal.font(18))
        setTitleColor(AppStyle.primary, for: .normal)
        tintColor = AppStyle.primary
        backgroundColor = .clear
    }
}
