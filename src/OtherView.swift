import Cocoa

class OtherView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //createColorBox()
        createColorInput()
        createColorPanel()
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
        Swift.print("createColorInput()")
        let colorInputCard:Card = container.addSubView(Card(NaN, NaN, "ColorInput: ", container, "colorInputCard"))
        colorInputCard
        let colorInput:ColorInput = colorInputCard.addSubView(ColorInput(NaN,NaN,"Color: ",NSColor.magentaColor(),colorInputCard))
        colorInput
    }
    func createColorPanel(){
        var colorPanelCard:Card = container.addSubView(Card(NaN, NaN, "ColorPanel: ", container, "colorPanelSection"))
        var colorPanel = colorPanelCard.addSubView(ColorPanel(NaN,NaN,24,0xFF00FF,"Color",nil,nil,colorPanelSection))
        //colorPanel.setPosition(new Point(0,144));
        //colorPanel.setSize(300, 300);
    }
}