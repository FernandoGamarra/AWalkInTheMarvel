//
//  AdvancedTextField.swift
//  AWalkInTheMarvel
//
//  Created by Fernando Gamarra on 22/4/22.
//

import UIKit



private enum Constants {
    static let offset: CGFloat = 2
    static let placeholderSize: CGFloat = 14
}

final class AdvancedTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    
    // MARK: - Subviews
    private var border = UIView()
    private var label = UILabel()
    private var padlock: UIButton? = nil
    
    private var customBorderColor: UIColor? = nil
    private var customTextColor: UIColor? = nil
    private var customLabelColor: UIColor? = nil
    
    // MARK: - Private Properties
    private var scale: CGFloat {
        Constants.placeholderSize / fontSize
    }

    private var fontSize: CGFloat {
        font?.pointSize ?? 0
    }

    private var labelHeight: CGFloat {
        ceil(font?.withSize(Constants.placeholderSize).lineHeight ?? 0)
    }

    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }

    private var isEmpty: Bool {
        text?.isEmpty ?? true
    }

    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: Constants.offset + labelHeight, left: 0, bottom: Constants.offset, right: 0)
    }
    
    private var isPrivateText: Bool = false

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: Public / Configure Methods
    func setup()  {
        setupUI()
    }
    func setPrivateText(_ value: Bool) {
        isPrivateText = value

        if isPrivateText {
            let image = UIImage(named: "lock-supervisor_icon")
            padlock = UIButton()
            padlock!.isHidden = false
            padlock!.setImage(image, for: .normal)
            padlock!.addTarget(self, action: #selector(pressed_lock(sender:)), for: .touchUpInside)
            self.rightView = padlock
            self.rightViewMode = .always
            self.isSecureTextEntry = true
        }
        else {
            if padlock != nil {
                padlock!.removeTarget(nil, action: nil, for: .allEvents)
                padlock?.isHidden = true
                padlock = nil
            }
            self.isSecureTextEntry = false
        }

    }

    func setPlaceHolder(_ value: String) {
        placeholder = " " + value
        //placeholder = value
        label.text = placeholder
    }
    
    func setBackgroundColor(_ color: UIColor) {
        self.layer.backgroundColor = color.cgColor
    }
    
    func setUnderLineColor(_ color: UIColor) {
        customBorderColor = color
        border.backgroundColor = customBorderColor
    }
    
    func setTextColor(_ color: UIColor) {
        customTextColor = color
        self.textColor = customTextColor
    }
    
    func setTintColor(_ color: UIColor) {
        self.tintColor = color
    }
    
    func setPlaceholderColor(_ color: UIColor) {
        customLabelColor = color
        if isFirstResponder || !isEmpty {
            label.textColor = customLabelColor
        }
        else {
            label.textColor = .inactive
        }
    }
    
    func setFieldAlert(_ value: Bool) {
        if value {
            setPlaceholderColor(UIColor.red)
            setUnderLineColor(UIColor.red)
        }
        else  {
            setPlaceholderColor(customLabelColor!)
            setUnderLineColor(customLabelColor!)
        }
    }
    
    func setTextContent(_ value: String) {
        self.text = value
        updateLabel()
    }
    
    // MARK: - UITextField
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }

    override var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 2)
        updateLabel(animated: false)
    }

//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: textInsets)
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: textInsets)
//    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.inset(by: padding).inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
       return bounds.inset(by: padding).inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        // For padding in rightView button
        let rightBounds = CGRect(x: bounds.size.width - 22,
                                 y: self.layer.bounds.size.height > 18 ? (self.layer.bounds.size.height / 2) - 10 : 0,
                                 width: 18, height: 18)
        return rightBounds
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard !isFirstResponder else {
            return
        }

        label.transform = .identity
        label.frame = bounds.inset(by: textInsets)
    }

    // MARK: - Private Methods
    private func setupUI() {
        borderStyle = .none
        
        autocorrectionType = .no
        
        if self.isEnabled == false || customBorderColor == nil {
            border.backgroundColor = .inactive
        }
        else {
            border.backgroundColor = customBorderColor
        }
        border.isUserInteractionEnabled = false
        addSubview(border)

        label.textColor = .inactive
        label.font = font
        label.text = placeholder
        label.isUserInteractionEnabled = false
        addSubview(label)

        addTarget(self, action: #selector(handleEditing), for: .allEditingEvents)
        
    }
    
    @objc func pressed_lock(sender: UIButton!) {
        var image: UIImage!
            
        if self.isSecureTextEntry == true {
            image = UIImage(named: "lockOFF-supervisor_icon")
            self.isSecureTextEntry = false
        }
        else {
            image = UIImage(named: "lock-supervisor_icon")
            self.isSecureTextEntry = true
        }
        
        padlock?.setImage(image, for: .normal)
    }

    @objc
    private func handleEditing() {
        updateLabel()
        updateBorder()
    }

    private func updateBorder() {
        //let borderColor = isFirstResponder ? tintColor : .inactive
        let borderColor = (self.isEnabled == false || customBorderColor == nil) ? .inactive : customBorderColor
        UIView.animate(withDuration: .animation250ms) {
            self.border.backgroundColor = borderColor
        }
    }

    private func updateLabel(animated: Bool = true) {
        let isActive = isFirstResponder || !isEmpty

        let offsetX = -label.bounds.width * (1 - scale) / 2
        let offsetY = -label.bounds.height * (1 - scale) / 2

        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - labelHeight - Constants.offset)
            .scaledBy(x: scale, y: scale)

        if isActive && customLabelColor != nil {
            label.textColor = customLabelColor
        }
        else {
            label.textColor = .inactive
        }
        
        guard animated else {
            label.transform = isActive ? transform : .identity
            return
        }

        UIView.animate(withDuration: .animation250ms) {
            self.label.transform = isActive ? transform : .identity
        }
    }
}

private extension TimeInterval {
    static let animation250ms: TimeInterval = 0.25
}

private extension UIColor {
    static let inactive: UIColor = .gray
}
