//
//  Window.swift
//  Surtainly Not
//
//  Created by Tyler Hall on 9/5/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import AppKit

class Window: NSWindow {

    var theFrame: NSRect {
        guard let screen = NSScreen.main else { return .zero }
        let height: CGFloat = 24
        return NSRect(x: 0, y: screen.frame.size.height - height, width: screen.frame.size.width, height: height)
    }

    override func awakeFromNib() {
        backgroundColor = .windowBackgroundColor
        ignoresMouseEvents = true
        styleMask = [.borderless]
        styleMask.remove(.titled)
        orderBack(nil)
        level = NSWindow.Level.init(Int(CGWindowLevelForKey(CGWindowLevelKey.mainMenuWindow)))
        setFrame(theFrame, display: true)
    }
}
