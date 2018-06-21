//
//  ThemeView.swift
//  Ink
//
//  Created by Mike Leavy on 6/20/18.
//  Copyright © 2018 Squid Store. All rights reserved.
//

import UIKit

open class ThemeView: UIView {

    @IBInspectable public var backgroundColorName: String? {
        didSet {
            backgroundColor = themeColor
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(notification:)), name: ThemeManager.themeManagerThemeDidChangeNotification, object: nil)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(notification:)), name: ThemeManager.themeManagerThemeDidChangeNotification, object: nil)
    }
    
    @objc func themeChanged(notification: NSNotification) {
        backgroundColor = themeColor
    }
    
    public var themeColor: UIColor? {
        if let name = backgroundColorName {
            return UIColor.themed(name) ?? backgroundColor
        }
        return backgroundColor
    }

}
