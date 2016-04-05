import Cocoa

class OtherView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //createColorBox()
        //createColorInput()
        //createColorPanel()
        createGradientPanel()
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
        let colorPanelCard:Card = container.addSubView(Card(NaN, NaN, "ColorPanel: ", container, "colorPanelCard"))
        let colorPanel = colorPanelCard.addSubView(ColorPanel(NaN,NaN,24,NSColor.magentaColor(),"Color",colorPanelCard))
        colorPanel
        //colorPanel.setPosition(new Point(0,144));
        //colorPanel.setSize(300, 300);
    }
    func createGradientPanel(){
        let gradientPanelCard:Card = container.addSubView(Card(NaN, NaN, "GradientPanel: ", container, "gradientPanelCard"))
        let gradient:IGradient = Gradient(Gradients.deepPurple())
        let gradientPanel:GradientPanel = gradientPanelCard.addSubView(GradientPanel(200,NaN,20,gradient,gradientPanelCard))
        gradientPanel
    }
}