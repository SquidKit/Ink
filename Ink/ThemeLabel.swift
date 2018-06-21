//
//  ThemeLabel.swift
//  Ink
//
//  Created by Mike Leavy on 6/20/18.
//  Copyright © 2018 Squid Store. All rights reserved.
//

import UIKit

open class ThemeLabel: UILabel, Themeable {

    
    @IBInspectable public var textColorName: String? {
        didSet {
            textColor = themeColor
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(notification:)), name: ThemeManager.themeManagerThemeDidChangeNotification, object: nil)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(themeChanged(notification:)), name: ThemeManager.themeManagerThemeDidChangeNotification, object: nil)
    }
    
    @objc public func themeChanged(notification: NSNotification) {
        textColor = themeColor
    }
    
    public var themeColor: UIColor? {
        if let name = textColorName {
            return UIColor.themed(name) ?? textColor
        }
        return textColor
    }

}

