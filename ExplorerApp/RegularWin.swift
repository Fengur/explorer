import Cocoa
@testable import Element
@testable import Utils

enum ViewType{
    case basic,other,advance
}
extension ViewType{
    /**
     *
     */
    func view(_ type:ViewType)->NSView{
        let classType:AnyClass
        switch type{
            case .basic:
                classType = BasicView.self
            case .other:
                classType = OtherView.self
            case .advance:
                classType = AdvanceView.self
        }
        
    }
}
class RegularWin:Window{
    init() {
        super.init(1000, 800)
    }
    override func resolveSkin() {
        //super.resolveSkin()
        self.contentView = BasicView(frame.size.width,frame.size.height)//BasicView//AdvanceView(frame.width,frame.height)/*Sets the mainview of the window*/
        WinModifier.align(self, Alignment.centerCenter, Alignment.centerCenter)
    }
    override func windowDidResize(_ notification:Notification) {
        //notification
        //Swift.print("CustomWin.windowDidResize")
        (self.contentView as! Element).setSize(self.frame.size.width,self.frame.size.height)
    }
    required init(_ width:CGFloat, _ height:CGFloat) {fatalError("init has not been implemented")}
}
