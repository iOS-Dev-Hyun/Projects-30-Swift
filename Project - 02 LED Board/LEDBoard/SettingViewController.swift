//
//  SettingViewController.swift
//  LEDBoard
//
//  Created by HyunSoo on 1/17/24.
//

import UIKit

protocol LEDBoardSettingDelegate: AnyObject {
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor)
}

class SettingViewController: UIViewController {
    weak var delegate : LEDBoardSettingDelegate?
    var textColor: UIColor = .yellow
    var backgroundColor: UIColor = .black
    var ledText: String?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blackButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    private func configureView() {
        if let ledText = ledText {
            textField.text = ledText
        }
        changeTextColor(color: textColor)
        changeBackgroundColor(color: backgroundColor)
    }
    
    
    @IBAction func tapTextColorButton(_ sender: UIButton) {
        if sender == yellowButton {
            changeTextColor(color: .yellow)
            textColor = .yellow
        } else if sender == purpleButton {
            changeTextColor(color: .purple)
            textColor = .purple
        } else {
            changeTextColor(color: .green)
            textColor = .green
        }
    }
    
    @IBAction func tapBackgroundColorButton(_ sender: UIButton) {
        if sender == blackButton {
            changeBackgroundColor(color: .black)
            backgroundColor = .black
        } else if sender == blueButton {
            changeBackgroundColor(color: .blue)
            backgroundColor = .blue
        } else {
            changeBackgroundColor(color: .orange)
            backgroundColor = .orange
        }
    }
    
    @IBAction func tapSaveButton(_ sender: UIButton) {
        delegate?.changedSetting(text: textField.text,
                                 textColor: textColor,
                                 backgroundColor: backgroundColor)
        navigationController?.popViewController(animated: true)
    }
    
    private func changeTextColor(color: UIColor) {
        yellowButton.alpha = color == UIColor.yellow ? 1 : 0.2
        purpleButton.alpha = color == UIColor.purple ? 1 : 0.2
        greenButton.alpha = color == UIColor.green ? 1 : 0.2
    }
    
    private func changeBackgroundColor(color: UIColor) {
        blackButton.alpha = color == UIColor.black ? 1 : 0.2
        blueButton.alpha = color == UIColor.blue ? 1 : 0.2
        orangeButton.alpha = color == UIColor.orange ? 1 : 0.2
    }
}
