//
//  CustomTabBarViewController.swift
//  CustomTabBar
//
//  Created by 🅐🅝🅐🅢 on 15/05/18.
//  Copyright © 2018 nfnlabs. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UIViewController {

    //Content view to load view controller
    @IBOutlet weak var contentView: UIView!
    
    //IBOutlet for home button
    @IBOutlet weak var btnHome: UIButton!
    
    //Create an IBOutlet array of buttons to hold tab bar buttons.
    @IBOutlet var tabButtons: [UIButton]!
    
    
    //Variables to hold each ViewController associated with a tab
    var firstViewController: UIViewController!
    var secondViewController: UIViewController!
    var thirdViewController: UIViewController!
    var fourthViewController: UIViewController!
    
    //Variable for an array to hold the ViewControllers
    var viewControllers: [UIViewController]!
    
    /*
    - Variable to keep track of the tab button that is selected.
    - Set it to an initial value of 0. Will link the button's tag value to this variable. So an initial value of 0 will reference first button/
    */
    var selectedIndex: Int = 0
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Access the main Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //Instantiate each ViewController
        firstViewController = storyboard.instantiateViewController(withIdentifier: "firstViewController")
        secondViewController = storyboard.instantiateViewController(withIdentifier: "secondViewController")
        thirdViewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController")
        fourthViewController = storyboard.instantiateViewController(withIdentifier: "fourthViewController")
        
        //Add each viewController to viewControllers array
        viewControllers = [firstViewController, secondViewController, thirdViewController, fourthViewController]
        
        //Set the Initial
        tabButtons[selectedIndex].isSelected = true
        didPressTab(tabButtons[selectedIndex])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnHome.layer.cornerRadius = btnHome.bounds.width/2
    }
    
    //MARK: - Actions
    
    //Create a Shared Action for the tabBar buttons
    @IBAction func didPressTab(_ sender: UIButton) {
        
        //Get Access to the previous tab
        let previousIndex = selectedIndex
        
        //Set the selectedIndex to the tag value of which ever button was tapped
        selectedIndex = sender.tag
        
        //Remove the Previous ViewController and Set Button State
        tabButtons[previousIndex].isSelected = false
        self.setBtn_ui_forNormalState(sender: tabButtons[previousIndex])
        let previousVC = viewControllers[previousIndex]
        
        //Remove the previous ViewController
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        //Add the New ViewController and Set Button State
        sender.isSelected = true
        self.setBtn_ui_forSelectedState(sender: sender)
        let vc = viewControllers[selectedIndex]
        
        //Add the new ViewController.
        addChildViewController(vc)
        
         //Adjust the size of the ViewController view you are adding to match the contentView of your CustomTabBarViewController and add it as a subView of the contentView
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        //Call the viewDidAppear method of the ViewControlle
        vc.didMove(toParentViewController: self)
    }
    
    @IBAction func btnHomeOnClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(homeViewController, animated: true, completion: nil)
    }
    
    //MARK: - Helper Methods
    
    //Set button color for selected state
    func setBtn_ui_forSelectedState(sender: UIButton){
        sender.backgroundColor = UIColor.white
        sender.setTitleColor(UIColor.black, for: .selected)
    }
    
    //Set button color for normal state
    func setBtn_ui_forNormalState(sender: UIButton){
        sender.backgroundColor = UIColor.black
        sender.setTitleColor(UIColor.white, for: .normal)
    }

}

