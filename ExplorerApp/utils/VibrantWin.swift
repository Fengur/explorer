import Cocoa
@testable import Element
@testable import Utils
/**
 * Used for Translucent look
 */
class VibrantWin:TranslucentWin{
    convenience init(_ w:CGFloat,_ h:CGFloat){
        self.init(contentRect:NSRect(0,0,w,h), styleMask: [.borderless,.resizable], backing:NSBackingStoreType.buffered, defer: false)
        let view = ViewType.view(.basic,CGSize(w,h))/*Sets the mainview of the window*/
        self.contentView?.addSubview(view)
    }
}
