//
//  CocaStatusMenu.swift
//  Coca
//
//  Created by Angelo Cammalleri on 03.02.18.
//  Copyright © 2018 Kindred. All rights reserved.
//

import Cocoa

class StatusMenu: NSViewController {
    
    // MARK: Properties
    
    @IBOutlet var statusPopup: NSView!
    @IBOutlet var statusMenu: NSMenu!
    @IBOutlet var notifyItem: NSMenuItem!
    @IBOutlet var notifySeperator: NSMenuItem!
    
    var notify: Bool = false
    
    var state: KloState = .free {
        didSet {
            switch state {
            case .free:
                notifyItem.isHidden = true
                notifyItem.isEnabled = false
                notifySeperator.isHidden = true
                notifyItem.title = "Notify me when the toilet is unoccupied again!"
                
                if notify {
                    showNotification()
                }
            case .occupied:
                notifyItem.isHidden = false
                notifyItem.isEnabled = true
                notifySeperator.isHidden = false
            }
        }
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Status Menu
    
    @IBAction func didTapQuitMenu(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
    @IBAction func didTapNotify(_ sender: Any) {
        notify = true
        notifyItem.title = "You will be notified."
        notifyItem.isEnabled = false
    }
    
    // MARK: Notification
    
    func showNotification() -> Void {
        let notification = NSUserNotification()
        notification.title = "RUN! 💩"
        notification.informativeText = "The toilet is no longer occupied."
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
        
        notify = false
    }
}
