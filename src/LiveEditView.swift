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
        
    }
}
