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
        window.toolbar = NSToolbar(identifier: "DockySettingsToolbar")
        window.center()
        window.isReleasedWhenClosed = false
        self.init(window: window)
        window.delegate = self
    }

    func windowWillClose(_ notification: Notification) {
        onClose?()
    }
}
