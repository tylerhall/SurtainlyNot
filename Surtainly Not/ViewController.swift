//
//  ViewController.swift
//  Surtainly Not
//
//  Created by Tyler Hall on 9/5/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var stackView: NSStackView!

    lazy var scriptMenuItems: NSAppleScript = {
        let script = """
            try
                tell application "System Events"
                    set output to ""
                    set frontmostProcess to first process where it is frontmost
                    tell frontmostProcess
                        get every menu bar
                        tell menu bar 1
                            repeat with mbitem in every menu bar item
                                set theTitle to title of mbitem
                                set output to output & theTitle & "|||"
                            end repeat
                        end tell
                    end tell
                end tell
            on error errMsg

            end try
        """
        let appleScript = NSAppleScript(source: script)
        appleScript?.compileAndReturnError(nil)
        return appleScript!
    }()
    
    override func viewDidLoad() {
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(activeAppDidChange), name: NSWorkspace.didActivateApplicationNotification, object: nil)
        activeAppDidChange()
    }

    @objc func activeAppDidChange() {
        guard let str = scriptMenuItems.executeAndReturnError(nil).stringValue else { return }
        var items = str.components(separatedBy: "|||")
        guard items.count > 1 else { return }

        for view in stackView.arrangedSubviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }

        items.remove(at: 0)
        items.insert("", at: 0)

        var views = [NSView]()
        for i in 0..<items.count {
            let label = MenuItemLabel()
            label.text = items[i]

            if i == 0 {
                label.font = NSFont.boldSystemFont(ofSize: 20)
            } else if i == 1 {
                label.font = NSFont.boldSystemFont(ofSize: 13)
            } else {
                label.font = NSFont.systemFont(ofSize: 13)
            }
            
            views.append(label)
        }
        
        stackView.setViews(views, in: .leading)
    }
}
