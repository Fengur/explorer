import Cocoa

class LiveEditView:CustomView {
    var container:Container!
    
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //liveEditTest1()
        //liveEditTest2()
        
        Swift.print("~/Desktop/".tildePath)
        
        
        //let url = NSURL(fileURLWithPath: "~/Desktop".tildePath)

        /**/
        
        let fileWatcher = FileWatcher(["~/Desktop/test".tildePath])
        fileWatcher.start()
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
class FileWatcher {
    let paths: [String]
    var started = false
    var streamRef:FSEventStreamRef?
    var lastEventId:FSEventStreamEventId
    init(_ paths: [String], _ sinceWhen: FSEventStreamEventId) {
        self.lastEventId = sinceWhen
        self.paths = paths
    }
    /**
     *
     */
    let eventCallback: FSEventStreamCallback = { (stream: ConstFSEventStreamRef, contextInfo: UnsafeMutablePointer<Void>, numEvents: Int, eventPaths: UnsafeMutablePointer<Void>, eventFlags: UnsafePointer<FSEventStreamEventFlags>, eventIds: UnsafePointer<FSEventStreamEventId>) in
        Swift.print("eventCallback()")
        let fileSystemWatcher: FileWatcher = unsafeBitCast(contextInfo, FileWatcher.self)
        let paths = unsafeBitCast(eventPaths, NSArray.self) as! [String]
        for index in 0..<numEvents {
            fileSystemWatcher.handleEvent(eventIds[index], paths[index], eventFlags[index])
        }
        fileSystemWatcher.lastEventId = eventIds[numEvents - 1]
    }
    /**
     * NOTE: I think you need to create a switch to differentiate between eventFlags
     */
    func handleEvent(eventId: FSEventStreamEventId, _ eventPath: String, _ eventFlags: FSEventStreamEventFlags) {
        Swift.print("\t eventId: \(eventId) - eventFlags:  \(eventFlags) - eventPath:  \(eventPath)")
        switch eventFlags{
            case 128000:
                Swift.print("modified")
            case 67584:
                Swift.print("rename,add,remove")
            case 111872:
                Swift.print("delete")
            default:
                Swift.print("unsupported event: " + "\(eventFlags)")
                break;
        }
    }
    /**
     * Start listening for FSEvents
     */
    func start() {
        Swift.print("start - has started: " + "\(started)")
        if(started){return}/*<--only start if its not already started*/
        var context = FSEventStreamContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutablePointer<Void>(unsafeAddressOf(self))
        let flags = UInt32(kFSEventStreamCreateFlagUseCFTypes | kFSEventStreamCreateFlagFileEvents)
        streamRef = FSEventStreamCreate(kCFAllocatorDefault, eventCallback, &context, paths, lastEventId, 0, flags)
        FSEventStreamScheduleWithRunLoop(streamRef!, CFRunLoopGetMain(), kCFRunLoopDefaultMode)
        FSEventStreamStart(streamRef!)
        started = true
    }
    /**
     * Stop listening for FSEvents
     */
    func stop() {
        Swift.print("stop - has started: " + "\(started)")
        if(!started){return}/*<--only stop if it has been started*/
        FSEventStreamStop(streamRef!)
        FSEventStreamInvalidate(streamRef!)
        FSEventStreamRelease(streamRef!)
        streamRef = nil
        started = false
    }
    deinit {
        //stop()
    }
}
extension FileWatcher{
    convenience init(_ pathsToWatch: [String]) {
        self.init(pathsToWatch, FSEventStreamEventId(kFSEventStreamEventIdSinceNow))
    }
}