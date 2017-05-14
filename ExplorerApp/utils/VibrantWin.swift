import Cocoa
@testable import Element
@testable import Utils
/**
 * Used for Translucent look
 */
class VibrantWin:TranslucentWin{
    let w:CGFloat = 1000//500//350//
    let h:CGFloat = 800//400//300//
    init(){
        super.init()
        let view = ViewType.view(.basic,CGSize(w,h))/*Sets the mainview of the window*/
        self.contentView?.addSubview(view)
    }
}
