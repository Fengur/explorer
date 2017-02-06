import Foundation
@testable import Element
@testable import Utils

class Card:Element{
    var text:String;
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "", _ parent: IElement?, _ id: String?) {
        self.text = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        _ = addSubView(Element(NaN, NaN, self, "ruler"))
        _ = addSubView(Text(NaN, NaN, text, self, "cardText"))
    }
    required init(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
