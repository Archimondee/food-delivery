//
//  FDTextField.swift
//  FoodDelivery
//
//  Created by Bayu Yasaputro on 18/06/22.
//

import UIKit

@IBDesignable
public class FDTextField: UITextField {
    
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 36)
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor(rgb: 0xF2F2F2)
        
        font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        
        layer.masksToBounds = true
        
        update()
    }
    
    func update() {
        layer.cornerRadius = cornerRadius
    }
}
