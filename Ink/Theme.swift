//
//  Theme.swift
//  Ink
//
//  Created by Mike Leavy on 6/20/18.
//  Copyright © 2018 Squid Store. All rights reserved.
//

import UIKit



public protocol Theme {
    var name: String {get}
    func theme(named: String) -> Theme?
}

open class ThemeManager {
    public static let themeManagerThemeDidChangeNotification = NSNotification.Name(rawValue: "com.squidkit.notification.themeManagerThemeDidChangeNotification")
    static let themeManagerCurrentThemeKey = "com.squidkit.themeManagerCurrentThemeKey"
    
    public var theme: Theme? {
        get {
            guard let name = UserDefaults.standard.string(forKey: ThemeManager.themeManagerCurrentThemeKey) else {return defaultTheme}
            return defaultTheme?.theme(named: name)
        }
        set {
            UserDefaults.standard.set(newValue?.name, forKey: ThemeManager.themeManagerCurrentThemeKey)
            NotificationCenter.default.post(name: ThemeManager.themeManagerThemeDidChangeNotification, object: self)
            
            if let appearance = appearanceThemeable {
                appearance.prepareAppearance()
                let windows = UIApplication.shared.windows
                for window in windows {
                    for view in window.subviews {
                        view.removeFromSuperview()
                        window.addSubview(view)
                    }
                }
            }
        }
    }
    

    public var defaultTheme: Theme?
    public weak var appearanceThemeable: AppearanceThemeable?
    
    public var themeNameSeperator = "-"
    
    private var isCanonical: Bool {
        return theme?.name == defaultTheme?.name
    }
    
    public func color(_ named: String) -> UIColor? {
        guard  let theme = theme else {
            return nil
        }
        let name = isCanonical ? named : named+themeNameSeperator+theme.name
        var c = UIColor(named: name)
        if c == nil {
            c = UIColor(named: named)
        }
        return c
    }
    
    public static let shared = ThemeManager()
    
    
    private init() {
        
    }
}

public extension UIColor {
    public class func themed(_ named: String) -> UIColor? {
        return ThemeManager.shared.color(named)
    }
}

@objc public  protocol Themeable {
    @objc func themeChanged(notification: NSNotification)
    var themeColor: UIColor? {get}
}

public protocol AppearanceThemeable: AnyObject {
    func prepareAppearance()
}
