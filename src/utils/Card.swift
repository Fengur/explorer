import Foundation

class Card:Element{
    var text:String;
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "", _ parent: IElement?, _ id: String?) {
        self.text = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        addSubView(Element(NaN, NaN, self, "ruler"))
        addSubView(Text(NaN, NaN, text, self, "cardText"))
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}