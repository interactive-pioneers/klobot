//
//  AppDelegate.swift
//  Klobar
//
//  Created by Angelo Cammalleri on 07.02.18.
//  Copyright © 2018 Interactive Pioneers GmbH. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, KloControllerDelegate {
    
    var statusItem: StatusItem!
    var statusViewController: StatusMenu!
    var kloController: KloController!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Create status menu & popup
        statusViewController = StatusMenu()
        statusViewController.loadView()
        
        // Creating status item
        statusItem = StatusItem(menu: statusViewController.statusMenu)
        
        // Setting icon
        let icon = StatusIcon(iconInactive: #imageLiteral(resourceName: "kloFree"), iconActive: #imageLiteral(resourceName: "kloOccupied"))
        statusItem.icon = icon
        
        // Klo init
        kloController = KloController()
        kloController.delegate = self
    }
    
    func kloStateDidCHange(state: KloState) {
        DispatchQueue.main.async {
            self.statusItem.changeState(state: state)
            self.statusViewController.state = state
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
