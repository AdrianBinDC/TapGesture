//
//  ViewController.swift
//  TapGesture
//
//  Created by Adrian Bolinger on 5/10/17.
//  Copyright © 2017 Adrian Bolinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var bioView: UIView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    
    // constraint height
    @IBOutlet weak var bioViewHeightConstraint: NSLayoutConstraint!
    
    var bioViewHeight: CGFloat! {
        /*
         Here we're using a property observer to execute code whenever
         this value is updated
         */
        
        didSet {
            print("stackViewHeight updated to \(bioViewHeight)")
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseIn], animations: { 
                self.bioViewHeightConstraint.constant = self.bioViewHeight
                self.view.layoutIfNeeded()
            }) { _ in
                self.bioTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
                print("animation complete")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        bioViewHeight = bioViewHeightConstraint.constant
        bioViewHeight = UIScreen.main.bounds.height / 2 // sets initially to 1/2 height of screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
    }
    
    
    /*
     You'll need a tap gesture configured to pick up taps on the bioView
     */
    func configureTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleHeight(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        bioView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    /*
     This makes changes to the bioViewHeightConstraint. The animation work is done
     in didSet. All you're doing here is updating the constant.
     */
    
    func toggleHeight(sender: UITapGestureRecognizer) {
        if bioViewHeightConstraint.constant == UIScreen.main.bounds.height / 2 {
            // true
            bioViewHeight = UIScreen.main.bounds.height - 30
        } else {
            // false
            bioViewHeight = UIScreen.main.bounds.height / 2
        }
        
    }
}

