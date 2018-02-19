//
//  StatusItemController.swift
//  Coca
//
//  Created by Angelo Cammalleri on 02.02.18.
//  Copyright © 2018 Kindred. All rights reserved.
//

import Cocoa

struct StatusIcon {
    var iconInactive: NSImage?
    var iconActive: NSImage?
}

/// This enum defines on which click the main action is performed. For Coca the main action is toggling between active and inactive state.
enum ActionMode {
    case left
    case right
}

class StatusItem {
    
    // MARK: Public properties
    
    ///  The default main action is right because a close button has to be visible without right clicking.
    var mode: ActionMode = .right
    
    /// The icon that should be used for Cocas status item.
    var icon: StatusIcon? {
        didSet {
            statusItem.image = icon?.iconInactive
        }
    }
    
    var state: KloState = .free {
        didSet {
            if state == .free {
                statusItem.image = icon?.iconInactive
            } else {
                statusItem.image = icon?.iconActive
            }
        }
    }
    
    // MARK: Private properties
    
    private let statusMenu: NSMenu
    private let statusItem: NSStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    // MARK: Lifecycle
    
    init(menu: NSMenu, mode: ActionMode = .right) {
        statusMenu = menu
        setupControls()
        setupStyling()
    }
    
    // MARK: Setup
    
    /// Setup the styling of the status item
    private func setupStyling() {
        statusItem.highlightMode = false
    }
    
    /// Setup the controls of the status item
    private func setupControls() {
        // Registering for click events
        if let button = statusItem.button {
            button.action = #selector(statusBarButtonClicked)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
            button.target = self
        }
    }
    
    // MARK: StatusItem click logic
    
    /**
     Fired when statusBarItem is clicked.
     */
    @objc private func statusBarButtonClicked() {
        guard let event = NSApp.currentEvent else {
            fatalError("⛔️ Error no click event. ⛔️")
        }
        
        if event.type == .leftMouseUp {
            didLeftClick()
        } else {
            didRightClick()
        }
    }
    
    private func didLeftClick() {
        mode == .left ? mainAction() : secondaryAction()
    }
    
    private func didRightClick() {
        mode == .right ? mainAction() : secondaryAction()
    }
    
    // MARK: StatusItem actions
    
    /// The main action toggle between active and inactive.
    private func mainAction() {
//        toggleState()
    }
    
    /// The secondary action shows the coca menu.
    private func secondaryAction() {
        statusItem.highlightMode = true
        //statusItem.button?.highlight(true)
        statusItem.popUpMenu(statusMenu)
        statusItem.highlightMode = false
    }
    
    func changeState(state: KloState) {
        self.state = state
    }
}
