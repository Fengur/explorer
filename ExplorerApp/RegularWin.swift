import Cocoa
@testable import Element
@testable import Utils

class RegularWin:Window{
    init() {
        super.init(1000, 800)
    }
    override func resolveSkin() {
        //super.resolveSkin()
        self.contentView = ViewType.view(.basic,frame.size)
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
    }
    override func windowDidResize(_ notification:Notification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
    required init(_ width:CGFloat, _ height:CGFloat) {fatalError("init has not been implemented")}
}

enum ViewType{
    case basic,other,advance
}
extension ViewType{
    /**
     * Returns the mainview of the window
     */
    static func view(_ type:ViewType, _ size:CGSize)->NSView{
        switch type{
        case .basic:
            return BasicView(size.width,size.height)
        case .other:
            return OtherView(size.width,size.height)
        case .advance:
            return AdvanceView(size.width,size.height)
        }
    }
}
