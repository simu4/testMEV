//
//  ViewController.swift
//  TestMEV
//
//  Created by Kirill Netavskiy on 12.05.17.
//  Copyright © 2017 Kirill Netavskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var historyButton: UIButton!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var titleTextField: UITextField!
    var textString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            let vc = segue.destination as! InfoViewController
            parseString()
            vc.textString = textString
            clear()
        }
    }
    
    func parseString() {
        for char in titleTextField.text!.characters {
            if char == " " {
                textString += "%20"
            } else {
                textString += String(char)
            }
        }
    }
    
    func setupProperties() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.didTapView))
        view.addGestureRecognizer(viewTap)
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Movie-poster-design-trends"))
        historyButton.layer.cornerRadius = 8
        historyButton.layer.borderWidth = 1
        historyButton.layer.borderColor = UIColor.black.cgColor
        searchButton.layer.cornerRadius = 8
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func didTapView() {
        hideKeyboard()
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func clear() {
        textString = ""
        titleTextField.text = ""
    }
}
