import Cocoa
@testable import Element
@testable import Utils

class RegularWin:Window{
    override func resolveSkin() {
        //super.resolveSkin()
        self.contentView = OtherView(frame.size.width,frame.size.height)//BasicView//AdvanceView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    override func windowDidResize(_ notification: Notification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
}
