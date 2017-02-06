import Cocoa
@testable import Element
@testable import Utils
//this is the current window for the Stash app

class TranslucencyWin:NSWindow, NSApplicationDelegate, NSWindowDelegate{
    let w:CGFloat = 1000//500//350//
    let h:CGFloat = 800//400//300//
    override var canBecomeMain:Bool{return true}
    override var canBecomeKey:Bool{return true}/*If you want a titleless window to be able to become a key window, you need to create a subclass of NSWindow and override -canBecomeKeyWindow*/
    override var acceptsFirstResponder:Bool{return true}
    var visualEffectView:TranslucencyView?//we set the to the background 
    /**
     *
     */
    override init(contentRect: NSRect, styleMask style: NSWindowStyleMask, backing bufferingType: NSBackingStoreType, defer flag: Bool) {
        super.init(contentRect: NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing: NSBackingStoreType.buffered, defer: false)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
        Swift.print("frame.origin: " + "\(frame.origin)")
        self.contentView!.wantsLayer = true/*this can and is set in the view*/
        self.backgroundColor = NSColor.clear/*Sets the window background color*/
        self.makeKeyAndOrderFront(nil)//moves the window to the front
        self.makeMain()//makes it the apps main menu?
        self.hasShadow = true/*you have to set this to true if you want a shadow when using the borderlessmask setting*/
        //self.center()/*centers the window, this can also be done via setOrigin and calculating screen size etc*/
        self.isMovableByWindowBackground = false/*This enables you to drag the window around via the background*/
        self.delegate = self/*So that we can use this class as the Window controller aswell*/
        self.contentView = FlippedView(frame:NSRect(0,0,w,h))
        visualEffectView = TranslucencyView(frame:NSRect(0,0,w,h))
        
        self.contentView?.addSubview(visualEffectView!)
        
        let view = BasicView(w,h)//BasicView//LiveEditView(w,h)////(w,h)////// (w,h)////AdvanceView(w,h)//StashView(frame.width,frame.height)/*Sets the mainview of the window*/
        self.contentView?.addSubview(view)
    }
    func windowDidResize(_ notification: Notification) {
        //Swift.print("CustomWin.windowDidResize " + "\(self.frame.size)")
        visualEffectView!.setFrameSize(self.frame.size)
    }
}
