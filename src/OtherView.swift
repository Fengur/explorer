import Cocoa

class OtherView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //createColorBox()
        createColorInput()
    }
    /**
     *
     */
    func createColorBox(){
        Swift.print("createColorBox")
        let colorBoxCard:Card = container.addSubView(Card(NaN, NaN, "ColorBox: ", container, "colorBoxCard"))
        colorBoxCard
        let colorBox = colorBoxCard.addSubView(ColorBox(NaN,NaN,NSColor.cyanColor(),colorBoxCard))
        colorBox
    }
    func createColorInput(){// :TODO: inpliment TextInput TextAre in the css
        var colorInputBox:Section = addSubView(Section(NaN, NaN, "ColorInput: ", self, "colorInputSection"))
        var colorInput:ColorInput = colorInputBox.addSubView(ColorInput(NaN,NaN,"Color: ",NSColor.magentaColor(),colorInputBox))
    }
}