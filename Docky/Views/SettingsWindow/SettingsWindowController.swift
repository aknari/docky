//
//  SettingsWindowController.swift
//  Docky
//

import AppKit
import SwiftUI

final class SettingsWindowController: NSWindowController, NSWindowDelegate {
    var onClose: (() -> Void)?

    convenience init() {
        let rootViewController = NSHostingController(rootView: SettingsRootView())
        let window = NSWindow(contentViewController: rootViewController)
        window.setContentSize(NSSize(width: 820, height: 540))
        window.minSize = NSSize(width: 720, height: 480)
        window.styleMask.insert(.closable)
        window.styleMask.insert(.miniaturizable)
        window.styleMask.insert(.resizable)
        window.styleMask.insert(.fullSizeContentView)
        window.title = "Settings"
        window.titleVisibility = .hidden
        // Keep the full-height sidebar, but let AppKit draw the titlebar's
        // own background: with a transparent bar the grouped forms scrolled
        // their rows straight over the pane title instead of under it.
        window.titlebarAppearsTransparent = false
        window.toolbarStyle = .unified
        // Let SwiftUI create the toolbar. Assigning an empty NSToolbar here
        // left its items (back/forward and the pane title) uninstalled until
        // the first selection change, so a freshly opened window had none.
        window.center()
        window.isReleasedWhenClosed = false
        self.init(window: window)
        window.delegate = self
    }

    func windowWillClose(_ notification: Notification) {
        onClose?()
    }
}
