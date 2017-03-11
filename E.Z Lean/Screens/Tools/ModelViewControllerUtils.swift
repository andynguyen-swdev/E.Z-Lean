//
//  ViewControllerUtils.swift
//  E.Z Lean
//
//  Created by LuanNX on 3/6/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import IBAnimatable
class ModelViewController: UIViewController{
    var textFieldArr : [UITextField]!
    var tag = 0
    var animatableTFArr: [AnimatableTextField]!
    let disposeBag = DisposeBag()
}
extension ModelViewController {
    func addDoneButton(textFields : [UITextField]){
        let toolBar = BorderedToolBar()
        toolBar.isOpaque = true
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
            
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClicked))
        doneButton.tintColor = .black
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: nil, action: #selector(backAction))
    
        let next = UIBarButtonItem(image: UIImage(named: "next"), style: .done, target: nil, action: #selector(nextAction))
        toolBar.setItems([back,next,flexibleSpace,doneButton], animated: false)
        for tf in textFields {
            tf.tintColor = .black
            tf.inputAccessoryView = toolBar
        }
        
        
    }
    func backAction(){
        if let backTF = self.view.viewWithTag(self.tag-1) as? UITextField {
            backTF.becomeFirstResponder()
            
        } else {
            self.view.endEditing(true)
        }
    }
    func nextAction(){
        if let backTF = self.view.viewWithTag(tag+1) as? UITextField {
            backTF.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
    }
    func addTargetForAll(textFields : [UITextField]){
        for tf in textFields {
            tf.addTarget(self, action: #selector(setTag), for: .editingDidBegin)
        }
    }
    func addTargetForAllAnimatable(textFields : [AnimatableTextField]){
        addTargetForAll(textFields: textFields)
    }
    func addDoneButtonForAnimatableTF(textFields : [AnimatableTextField]){
        addDoneButton(textFields: textFields)
    }
    func setTag(text: UITextField){
        tag = text.tag
    }
    func doneClicked() {
        self.view.endEditing(true)
    }
    func configNavigationCenter(scrollView: UIScrollView) {
        NotificationCenter.default
            .rx
            .notification(Notification.Name.UIKeyboardWillChangeFrame)
            .concat(NotificationCenter
                .default
                .rx
                .notification(Notification.Name.UIKeyboardWillHide)
            )
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .userInteractive))
            .subscribe(onNext: { [unowned self] in
                self.adjustForKeyboard(notification: $0,scrollView: scrollView)
            })
            .addDisposableTo(disposeBag)
    }
    
    func adjustForKeyboard(notification: Notification,scrollView : UIScrollView) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = self.view.convert(keyboardScreenEndFrame, from: self.view.window)
        let intersection = keyboardViewEndFrame.intersection(scrollView.frame)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            scrollView.contentInset.bottom = 0
        } else {
            scrollView.contentInset.bottom = intersection.height
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
}

class BorderedToolBar: UIToolbar, BorderDesignable {
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            configureBorder()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
        didSet {
            configureBorder()
        }
    }
    
    open var borderSides: BorderSides  = .AllSides {
        didSet {
            configureBorder()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureBorder()
    }
}

