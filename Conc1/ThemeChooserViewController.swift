//
//  ThemeChooserViewController.swift
//  Conc1
//
//  Created by Kamil Gucik on 18/02/2020.
//  Copyright © 2020 Kamil. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    
    
    let themes = [
        "Winter":"❄️☃️🥶🎿🏂",
        "Holidays":"🏖🏝🎁⛵️🛳",
        "Halloween":"👻🎃🤡👹🧠",
        "Tech":"🎥💿🖥📷🖲"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewControler {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewControler {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
                cvc.themeLabel.text = themeName
            }
            navigationController?.pushViewController(cvc, animated: true)
            cvc.themeChosed = (sender as? UIButton)?.currentTitle
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
        private var splitViewDetailConcentrationViewController: ConcentrationViewControler? {
            return splitViewController?.viewControllers.last as? ConcentrationViewControler
        }
    
    private var lastSeguedToConcentrationViewControler: ConcentrationViewControler?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
                if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                    if let cvc = segue.destination as? ConcentrationViewControler {
                        cvc.theme = theme
                        lastSeguedToConcentrationViewControler = cvc
                        cvc.themeChosed = themeName
                        
                    }
            }
        }
        
    }

}

