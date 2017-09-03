//
//  ViewController.swift
//  DialogsAndAnimations
//
//  Created by Tomer Buzaglo on 31/08/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var dialogView: UIView!
    var isDialogVisible:Bool = false
    
    @IBAction func toss(_ sender: UIButton) {
        
        
        let img = UIImageView(image: #imageLiteral(resourceName: "icons8-desura"))
        
        img.center = view.center
        img.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
        
        
        self.view.addSubview(img)
        
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: { 
            img.transform = CGAffineTransform.identity
        }, completion: nil)
        
 
        UIView.animate(withDuration: 0.3, delay: 0.7, options: .curveEaseInOut, animations: { 
            img.alpha = 0
        }) { (isComplete) in
            img.removeFromSuperview()
        }
    }
    @IBOutlet weak var menuHeightConstraint: NSLayoutConstraint!
    
    var isMenuOpen = true
    @IBAction func showBottomMenu(_ sender: UIBarButtonItem) {
        menuHeightConstraint.constant = isMenuOpen ? 0 : 100
        isMenuOpen = !isMenuOpen
        
        //TODO: fade in / out
        
        
        //        UIView.animate(withDuration: 0.3) {
        //            //animate a constraint:
        //            self.view.layoutIfNeeded()
        //        }
        //options:
        //        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
        //            self.view.layoutIfNeeded()
        //        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    //Excplicitly unwrapped optional.
    var blurEffect:UIVisualEffect!
    
    @IBOutlet weak var blurView: UIVisualEffectView!{
        //Property Observer
        didSet{
            //save the effect for later
            blurEffect = blurView.effect
            //for now set the effect to nil
            blurView.effect = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let p = touches.first?.location(in: view) else {return}
        
        if !dialogView.frame.contains(p){
            dismissDialog()
        }
        /*
         //clision detection:
         let width = dialogView.frame.width
         let height = dialogView.frame.height
         
         let dX = dialogView.frame.origin.x
         let dY = dialogView.frame.origin.y
         
         //is point.x between dX and dX + width
         let isInDialogX = p.x >= dX && p.x <= dX + width
         
         //is point.Y between dY and dY + height
         let isInDialogY = p.y >= dY && p.y <= dY + height
         
         if isInDialogX && isInDialogY{
         print("Inside")
         }else{
         print("Outside")
         }
         */
        
        /*
         if dialogView.frame.contains(p) {
         print("Inside")
         }else{
         print("OutSide")
         }
         */
        
    }
    func dismissDialog(){
        self.blurView.effect = nil
        UIView.animate(withDuration: 0.4, animations: {
            self.dialogView.transform = CGAffineTransform(translationX: 0, y: -1000)
        })
        { (complete) in
            self.dialogView.removeFromSuperview()
        }
        isDialogVisible = false
    }
    
    
    @IBAction func toggleDialog(_ sender: UIBarButtonItem) {
        //trinary condition operator
        isDialogVisible ? dismissDialog() : showDialog()
    }
    
    func showDialog(){
        dialogView.center.x = self.view.center.x
        dialogView.center.y = self.view.center.y
        
        //transforms: CGAffineTransform
        //scale
        //rotate
        //tranistion (x, y)
        //identity
        
        dialogView.transform = CGAffineTransform(translationX: 0,  y: -view.frame.height / 2)
        view.addSubview(dialogView)
        
        UIView.animate(withDuration: 0.1) {
            self.dialogView.transform = CGAffineTransform.identity
            self.blurView.effect = self.blurEffect
        }
        
        isDialogVisible = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print(segue.identifier ?? "")
//        
//        print(segue.destination)
//        
//        
        if let dest = segue.destination as? IconCollectionViewController{
            dest.addIconTossedListener(listener: { (img) in
                //toss the image
                
                let img = UIImageView(image: img)
                
                img.center = self.view.center
                img.transform = CGAffineTransform(translationX: 0, y: self.view.frame.height)
                
                
                self.view.addSubview(img)
                
                
                UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10, options: [], animations: {
                    img.transform = CGAffineTransform.identity
                }, completion: nil)
                
                
                UIView.animate(withDuration: 0.3, delay: 0.7, options: .curveEaseInOut, animations: {
                    img.alpha = 0
                }) { (isComplete) in
                    img.removeFromSuperview()
                }
                
            })
        }
    }
}

































