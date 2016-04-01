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
        Swift.print("createColorBox")
        let colorBoxCard:Card = container.addSubView(Card(200, 120, "ColorBox: ", container, "colorBoxCard"))
        colorBoxCard
        //let colorBox = colorBoxCard.addSubView(ColorBox(24,24,NSColor.cyanColor(),colorBoxCard))
        //colorBox
    }
}