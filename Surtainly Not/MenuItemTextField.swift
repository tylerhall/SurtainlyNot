//
//  MenuItemTextField.swift
//  Surtainly Not
//
//  Created by Tyler Hall on 9/5/20.
//  Copyright © 2020 Tyler Hall. All rights reserved.
//

import Cocoa

class MenuItemLabel: NSView {

    var text = ""
    var textColor: NSColor = .labelColor
    var font = NSFont.systemFont(ofSize: 13)

    var backgroundColor: NSColor = .clear {
        didSet {
            setNeedsDisplay(bounds)
        }
    }
    
    var attrs: [NSAttributedString.Key: Any] {
        return [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.backgroundColor: NSColor.clear]
    }

    override func draw(_ dirtyRect: NSRect) {
        backgroundColor.setFill()
        NSBezierPath(rect: bounds).fill()
        
        let size = (text as NSString).size(withAttributes: attrs)
        let iSize = intrinsicContentSize
        let point = CGPoint(x: iSize.width / 2 - size.width / 2, y: iSize.height / 2 - size.height / 2)
        (text as NSString).draw(at: point, withAttributes: attrs)
    }
    
    override var intrinsicContentSize: NSSize {
        let size = (text as NSString).size(withAttributes: attrs)
        return NSSize(width: size.width + 20, height: 25)
    }

    func track() {
        let area = NSTrackingArea(rect: NSRect(origin: .zero, size: intrinsicContentSize), options: [.activeAlways, .mouseEnteredAndExited], owner: self, userInfo: nil)
        addTrackingArea(area)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        if NSEvent.pressedMouseButtons > 0 {
            backgroundColor = .selectedMenuItemColor
        } else {
            backgroundColor = .clear
        }
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        if NSEvent.pressedMouseButtons > 0 {
            backgroundColor = .selectedMenuItemColor
        } else {
            backgroundColor = .clear
        }
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        backgroundColor = .clear
    }
}
