//
//  ViewController.swift
//  LifeCycle
//
//  Created by Yubin Kim on 2023-06-03.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            print("View did load")
            // This method is called after the view has been loaded into memory.
            // Perform any additional setup here.
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("View will appear")
            // This method is called when the view is about to appear on the screen.
            // Perform any UI updates or data refresh here.
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            print("View did appear")
            // This method is called when the view has appeared on the screen.
            // Perform any animations or start timers here.
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            print("View will disappear")
            // This method is called when the view is about to be removed from the screen.
            // Perform any cleanup or saving of data here.
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            print("View did disappear")
            // This method is called after the view has been removed from the screen.
            // Perform any additional cleanup here.
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            print("Did receive memory warning")
            // This method is called when the system is running low on memory.
            // You can release any additional resources here.
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            print("View will layout subviews")
            // This method is called just before the view's layout is updated.
            // Perform any custom layout adjustments here.
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            print("View did layout subviews")
            // This method is called after the view's layout has been updated.
            // Perform any additional layout-related tasks here.
        }
        
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            print("View will transition to size: \(size)")
            // This method is called when the view is about to transition to a new size.
            // Use this method to update the layout or perform any other tasks related to the transition.
        }

}

