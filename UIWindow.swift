//
//  UIWindow.swift
//  Closure
//
//  Created by Li, Lucas on 10/17/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import ObjectiveC
import UIKit

private var tipsKey:UInt8 = 0
private var tapKey:UInt8 = 0


extension UIWindow {
    
    class func showTips(_ text: String?) {
        let del = UIApplication.shared.delegate as? AppDelegate
        guard  let window = del?.window else {return}

        var tips = objc_getAssociatedObject(self, &tipsKey) as? UITextView
        
        if tips != nil {
            self.dismiss()
            Thread.sleep(forTimeInterval: 0.5)
        }
        let maxWidth: CGFloat = 200
        let maxHeight = window.frame.size.height - 200
        let commonInset: CGFloat = 10

        let font = UIFont.systemFont(ofSize: 12)
        let string = NSMutableAttributedString(string: text ?? "")
        string.addAttribute(.font, value: font, range: NSRange(location: 0, length: string.length))
        let rect = string.boundingRect(with: CGSize(width: maxWidth, height: 10000), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        
        let height = rect.size.height < maxHeight ? rect.size.height : maxHeight

        let size = CGSize(width: rect.size.width, height: height)

        
        let textX = window.frame.size.width / 2 - (size.width + commonInset * 2)/2
        let textY = window.frame.size.height - (size.height + commonInset * 2) - 100
        let textWidth = size.width + commonInset * 2
        let textHeight = size.height + commonInset * 2

        let textFrame = CGRect(x: textX, y: textY, width: textWidth , height: textHeight)
        tips = UITextView(frame: textFrame)
        tips?.text = text
        tips?.font = font
        tips?.textColor = UIColor.white
        tips?.backgroundColor = UIColor.black
        tips?.layer.cornerRadius = 5
        tips?.isEditable = false
        tips?.isSelectable = false
        tips?.isScrollEnabled = false
        tips?.textContainer.lineFragmentPadding = 0
        tips?.contentInset = UIEdgeInsets(top: commonInset, left: commonInset, bottom: commonInset, right: commonInset)

        let tap = UITapGestureRecognizer(target: self, action: #selector(handlerGuesture(_:)))

        window.addGestureRecognizer(tap)
        window.addSubview(tips!)

    objc_setAssociatedObject(self, &tapKey, tap, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    objc_setAssociatedObject(self, &tipsKey, tips, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

    self.perform(#selector(dismiss), with: nil, afterDelay: 2.0)
}

@objc class func handlerGuesture(_ sender: UIGestureRecognizer?) {
    if sender == nil || sender?.view == nil {
        return
    }
    self.dismiss()
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(dismiss), object: nil)
}

@objc class func dismiss() {
    let del = UIApplication.shared.delegate as? AppDelegate
    guard  let window = del?.window else {return}
    
    let tap = objc_getAssociatedObject(self, &tapKey) as? UITapGestureRecognizer
    if let tap = tap {
        window.removeGestureRecognizer(tap)
    }

    let tips = objc_getAssociatedObject(self, &tipsKey) as? UITextView

    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
        tips?.alpha = 0.0
    }) { finished in
        tips?.removeFromSuperview()
    }
}
}
