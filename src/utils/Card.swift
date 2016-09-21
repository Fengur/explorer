import Foundation

class Card:Element{
    var text:String;
    init(_ width: CGFloat, _ height: CGFloat, _ text:String = "", _ parent: IElement?, _ id: String?) {
        self.text = text
        super.init(width, height, parent, id)
    }
    override func resolveSkin() {
        super.resolveSkin()
        Swift.print("getWidth(): " + "\(getWidth())")
        Swift.print("getHeight(): " + "\(getHeight())")
        addSubView(Element(NaN, NaN, self, "ruler"))
        Swift.print("card.ruler created")
        addSubView(Text(NaN, NaN, text, self, "cardText"));
        Swift.print("card text created")
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}


//continue here: the problem is in Text. probably the color isnt getting through correctly