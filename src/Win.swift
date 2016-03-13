import Cocoa

class Win:Window{
    override func resolveSkin() {
        //super.resolveSkin()
        self.contentView = /*TestView8*/BasicView(frame.width,frame.height)/*Sets the mainview of the window*/
    }
    override func windowDidResize(notification: NSNotification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
}