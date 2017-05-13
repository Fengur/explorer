import Cocoa
@testable import Element
@testable import Utils

class OtherView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        createColorBox()
        createColorInput()
        createColorPanel()
        createGradientPanel()
    }
    func createColorBox(){
        let card:Card = container.addSubView(Card(NaN, NaN, "ColorBox: ", container, "colorBoxCard"))
        let colorBox = card.addSubView(ColorBox(NaN,NaN,NSColor.cyan,card))
        _ = colorBox
    }
    func createColorInput(){// :TODO: inpliment TextInput TextAre in the css
        let colorInputCard:Card = container.addSubView(Card(NaN, NaN, "ColorInput: ", container, "colorInputCard"))
        let colorInput:ColorInput = colorInputCard.addSubView(ColorInput(NaN,NaN,"Color: ",NSColor.magenta,colorInputCard))//NSColorParser.nsColor(Colors.MAGENTA)
        _ = colorInput
    }
    func createColorPanel(){
        let colorPanelCard:Card = container.addSubView(Card(NaN, NaN, "ColorPanel: ", container, "colorPanelCard"))
        let colorPanel = colorPanelCard.addSubView(ColorPanel(NaN,NaN,24,NSColor.magenta,"Color",colorPanelCard))
        _ = colorPanel
        //colorPanel.setPosition(new Point(0,144));
        //colorPanel.setSize(300, 300);
    }
    func createGradientPanel(){
        let gradientPanelCard:Card = container.addSubView(Card(NaN, NaN, "GradientPanel: ", container, "gradientPanelCard"))
        let gradientColors:Array<CGColor> = [NSColor.red.cgColor, NSColor.blue.cgColor]
        var gradient:IGradient = LinearGradient(gradientColors,[],0)
        gradient.colors = Gradients.deepPurple()
        let gradientPanel:GradientPanel = gradientPanelCard.addSubView(GradientPanel(200,NaN,20,gradient,gradientPanelCard))
        _ = gradientPanel
    }
}
