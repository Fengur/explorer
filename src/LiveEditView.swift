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
    var fileWatcher:FileWatcher?
    
    
    var temp:String = "123"
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //liveEditTest1()
        //liveEditTest2()
        
        //Swift.print("~/Desktop/".tildePath)
        
        
        //let url = NSURL(fileURLWithPath: "~/Desktop".tildePath)

        /**/
        
        
        

       
        fileWatcher = FileWatcher(["~/Desktop/test/text.txt".tildePath],FSEventStreamEventId(kFSEventStreamEventIdSinceNow))
        
        fileWatcher!.event = { [weak self] eventId, eventPath, eventFlags in
            //let url = NSURL(fileURLWithPath: eventPath)
            Swift.print("event " + "\(self?.temp)")
            let url = NSURL(fileURLWithPath: eventPath)
            url
            if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemIsFile)) != 0 {
                Swift.print("file change")
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemCreated)) != 0 {
                    // file created
                }
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRemoved)) != 0 {
                    // file removed
                    Swift.print("File removed: \(eventPath) - \(eventId)")
                    
                }
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRenamed)) != 0 {
                    // file renamed
                }
                // file change
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemModified)) != 0 {// file modified
                    Swift.print("File modified: \(eventPath) - \(eventId)")
                }
            }
            if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemIsDir)) != 0 {
                // directory change
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemCreated)) != 0 {
                    // directory created
                    Swift.print("directory created: \(eventPath)")
                }
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRemoved)) != 0 {
                    // directory removed
                    Swift.print("directory removed: \(eventPath)")
                    
                }
                if (eventFlags & FSEventStreamEventFlags(kFSEventStreamEventFlagItemRenamed)) != 0 {
                    // directory renamed
                }
            }
            
        }
        
        fileWatcher!.start()
        
        
        self.temp += "abc"
        
        //let fileWatcherB = FileWatcher(["~/Desktop/test/text2.txt".tildePath],FSEventStreamEventId(kFSEventStreamEventIdSinceNow))
        //fileWatcherB.start()
         /**/
        /*
        let theEventHandler:(event:FileWatch.Event)->Void = { event in
        //Swift.print("test")
        debugPrint(event.path)
        /*if event.flag.contains(.ItemIsFile) {
        debugPrint(event.path)
        
        }*/
        }/**/
        
        
        let filewatch = try! FileWatch(paths: ["~/Desktop/test/text.txt".tildePath],  createFlag: [.UseCFTypes, .FileEvents], runLoop: NSRunLoop.currentRunLoop(), latency: 3.0, eventHandler: { event in
        if event.flag.contains(.ItemIsFile) {
        debugPrint(event.path)
        }
        })*/
        
        //fileWatcher.event = handleEvent
        
        //Dispatch Event/Post Notification:
        
        
        //Listen for Event/Observe Notification:
        
        
        
        
        
        
        
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
