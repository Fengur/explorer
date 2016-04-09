import Cocoa

class LiveEditView:CustomView {
    var container:Container!
    
    
    func handleEvent(event:Event) {
        Swift.print("handleEvent()")
        //Swift.print("\t eventId: \(eventeventId) - eventFlags:  \(eventFlags) - eventPath:  \(eventPath)")
        
        /*switch eventFlags{
        case Flags.dataChange:
        Swift.print("data change")
        case Flags.change:
        Swift.print("file change")
        case Flags.delete:
        Swift.print("delete")
        case Flags.added:
        Swift.print("added")
        default:
        Swift.print("unsupported event: " + "\(eventFlags)")
        break;
        
        
        }*/
    }
    func theEventHandler(event:FileWatch.Event){
        Swift.print("works")
        if event.flag.contains(.ItemIsFile) {
            debugPrint(event.path)
        }
    }
    var outsideVar:String = "test"
    
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //liveEditTest1()
        //liveEditTest2()
        
        Swift.print("~/Desktop/".tildePath)
        
        
        //let url = NSURL(fileURLWithPath: "~/Desktop".tildePath)

        /**/
        
        
        
        //let fileWatcher = FileWatcher(["~/Desktop/test/text.txt".tildePath])
        //fileWatcher.start()
        
        
        
        
        let testing:(event:FileWatch.Event)->Void = { event in
            Swift.print("works " + self.outsideVar)
            if event.flag.contains(.ItemIsFile) {
                debugPrint(event.path)
            }
        }
        
        let filewatch = try! FileWatch(paths: ["~/Desktop/test/text.txt".tildePath],  createFlag: [.UseCFTypes, .FileEvents], runLoop: NSRunLoop.currentRunLoop(), latency: 3.0, eventHandler: testing)
        filewatch
        
        
        //fileWatcher.event = handleEvent

        
        
    }
    
    /**
     *
     */
    func liveEditTest1(){
        StyleManager.addStyle("#redBox{fill:red;float:left;clear:left;}")
        let redBox = addSubView(Element(100,100,self,"redBox"))
        
        StyleManager.addStyle("#btn1{fill:green;float:left;clear:left;}")
        let btn = addSubView(Button(100,20,self,"btn1"))
        
        func onButtonClick(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("click")
                redBox
                let style = StyleManager.getStyle("#redBox")
                var styleProperty = style?.getStyleProperty("fill")
                Swift.print("styleProperty?.value: " + "\(styleProperty?.value)")
                styleProperty!.value = ("0x"+NSColor.magentaColor().hexString).uint
                Swift.print("styleProperty?.value: " + "\(StyleManager.getStyle("#redBox")?.getStyleProperty("fill")?.value)")
                ElementModifier.refresh(self)
            }
        }
        btn.event = onButtonClick
    }
    /**
     *
     */
    func liveEditTest2(){
        //create a testBtn
        StyleManager.addStyle("#testButton{fill:grey9;float:left;clear:left;corner-radius:4px;}")
        let testButton = addSubView(Button(100,20,self,"testButton"))
        
        //create a light theme button
        StyleManager.addStyle("#lightTheme{fill:grey9;float:left;clear:left;corner-radius:4px;}")
        let lightThemeButton = addSubView(Button(100,20,self,"lightTheme"))
        //create a dark theme button
        StyleManager.addStyle("#darkTheme{fill:grey3;float:left;clear:left;corner-radius:4px;}")
        let darkThemeButton = addSubView(Button(100,20,self,"darkTheme"))
        

        func onButtonClick(event:Event){//manually change the styles that belong to the button that will change.
            if(event.type == ButtonEvent.upInside){
                //let style = StyleManager.getStyle("#testButton")
                //var styleProperty = style?.getStyleProperty("fill")
                StyleManager.removeStyle("#testButton")
                if(event.origin === lightThemeButton){
                    StyleManager.addStylesByURL("~/Desktop/light.css")
                    //styleProperty!.value = StyleManager.getStyle("#lightTheme")!.getStyleProperty("fill")!.value
                }else if(event.origin === darkThemeButton){
                    StyleManager.addStylesByURL("~/Desktop/dark.css")
                    //styleProperty!.value = StyleManager.getStyle("#darkTheme")!.getStyleProperty("fill")!.value
                }
                Swift.print(StyleManager.getStyle("#testButton")!.getStyleProperty("fill")!.value)
            }
            ElementModifier.refreshSkin(self)//refresh self

            //testButton.setSkinState(SkinStates.none)
        }
        lightThemeButton.event = onButtonClick//onClick
        darkThemeButton.event = onButtonClick
    }
}
