//
//  InputTextField.swift
//  CleanArchitecture_ShipGo
//
//  Created by 이범준 on 2023/08/02.
//

import UIKit
import Combine

enum CurrentPasswordInputStatus {
    case valid
    case invalid
}

class InputTextField: UITextField {
    private var rightButton: UIButton!
    private var cancelBag = Set<AnyCancellable>()
    private var currentInputStatus: CurrentPasswordInputStatus = .invalid
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        delegate = self
        rightViewMode = .always
        leftViewMode = .always
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: Int(moderateScale(number: 20)), height: Int(self.frame.height)))
        self.leftView = leftPaddingView
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: Int(moderateScale(number: 20)), height: Int(self.frame.height)))
        rightPaddingView.backgroundColor = .black
        self.rightView = rightPaddingView
        self.backgroundColor = ColorManager.defaultForegroundDisabled
        self.layer.cornerRadius = 10
        autocapitalizationType = .none
    }
    
    public func setupValidStatus() {
        textColor = .black
        layer.borderColor = ColorManager.primaryColor?.cgColor
        currentInputStatus = .valid
    }
    
    public func setupInvalidStatus(error: String) {
        shake()
        text = ""
        attributedPlaceholder = NSAttributedString(string: error, attributes: [NSAttributedString.Key.foregroundColor : ColorManager.negativeColor])
        layer.borderWidth = 2.0
        layer.borderColor = ColorManager.negativeColor?.cgColor
        currentInputStatus = .invalid
    }
}

extension InputTextField: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty, currentInputStatus == .invalid {
            textField.text = ""
            setupValidStatus()
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderWidth = 2.0
        self.text = ""
        setupValidStatus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderWidth = 0.0
        self.layer.borderColor = .none
    }
}
