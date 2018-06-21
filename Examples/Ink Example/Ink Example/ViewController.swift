//
//  ViewController.swift
//  Ink Example
//
//  Created by Mike Leavy on 6/20/18.
//  Copyright © 2018 Squid Store. All rights reserved.
//

import UIKit
import Ink

class ViewController: UIViewController {
    @IBOutlet weak var darknessSwitch: UISwitch!
    @IBOutlet weak var helloLabel: ThemeLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darknessSwitch.isOn = ThemeManager.shared.theme! == MyTheme.dark
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didChangeDarkness(_ sender: Any) {
        guard let darkness = sender as? UISwitch else {return}
        ThemeManager.shared.theme = darkness.isOn ? MyTheme.dark : MyTheme.light
    }
    
}

