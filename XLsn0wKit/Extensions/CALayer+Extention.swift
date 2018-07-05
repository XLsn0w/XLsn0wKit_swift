
import UIKit

extension CALayer {
    
    var shadowUIColor: UIColor? {
        get {
            if let cgColor = self.shadowColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            self.shadowColor = newValue?.cgColor
        }
    }
    
    var borderUIColor: UIColor? {
        get {
            if let cgColor = self.borderColor {
                return UIColor(cgColor: cgColor)
            }
            return nil
        }
        set {
            self.borderColor = newValue?.cgColor
        }
    }
}



