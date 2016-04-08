import Foundation

class LiveEditView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        liveEditTest1()
    }
    /**
     *
     */
    func liveEditTest1(){
        StyleManager.addStyle("#redBox{fill:red;float:left;clear:left;}")
        let redbox = addSubView(Element(100,100,self,"redBox"))
        redbox
    }
}
