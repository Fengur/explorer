import Cocoa

class OtherView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        createColorBox()
    }
    /**
     *
     */
    func createColorBox(){
        let colorBoxCard:Card = addSubView(Card(NaN, NaN, "ColorBox: ", self, "colorBoxCard"))
        colorBoxCard
        let colorBox = colorBoxCard.addSubView(ColorBox(NaN,NaN,NSColor.cyanColor(),colorBoxCard))
        colorBox
    }
}