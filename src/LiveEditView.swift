import Cocoa

class LiveEditView:CustomView {
    var container:Container!
    var directoryObserver:DirectoryObserver?
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //liveEditTest1()
        //liveEditTest2()
        
        Swift.print("~/Desktop/".tildePath)
        
        /*
        let url = NSURL(fileURLWithPath: "~/Desktop".tildePath)
        let monitor = FolderMonitor(url: url, handler: {
        Swift.print("Found change")
        })
        
        
        monitor.start()
        */
        
        //monitor.stop()
        
        let theURL:NSURL = FilePathParser.path("~/Desktop/".tildePath)
        
        self.directoryObserver = DirectoryObserver(URL: theURL, block: { [weak self] in
            Swift.print("change: " + "\(self)")
            
            //self?.doSomething()
            })
        /**/
        
        /*let fileSystemWatcher = FileSystemWatcher(pathsToWatch: ["~/Desktop/".tildePath],sinceWhen: 0)
        fileSystemWatcher.start()*/
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

public class FolderMonitor {
    
    enum State {
        case On, Off
    }
    
    private let source: dispatch_source_t
    private let descriptor: CInt
    private let qq: dispatch_queue_t = dispatch_get_main_queue()
    private var state: State = .Off
    
    /// Creates a folder monitor object with monitoring enabled.
    public init(url: NSURL, handler: ()->Void) {
        
        state = .Off
        descriptor = open(url.fileSystemRepresentation, O_EVTONLY)
        
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE,UInt(descriptor),DISPATCH_VNODE_WRITE,qq)
        
        dispatch_source_set_event_handler(source, handler)
        start()
    }
    
    /// Starts sending notifications if currently stopped
    public func start() {
        if state == .Off {
            state = .On
            dispatch_resume(source)
        }
    }
    
    /// Stops sending notifications if currently enabled
    public func stop() {
        if state == .On {
            state = .Off
            dispatch_suspend(source)
        }
    }
    
    deinit {
        close(descriptor)
        dispatch_source_cancel(source)
    }
}

class DirectoryObserver {
    
    deinit {
        
        dispatch_source_cancel(source)
        close(fileDescriptor)
    }
    
    init(URL: NSURL, block: dispatch_block_t) {
        
        fileDescriptor = open(URL.path!, O_EVTONLY)
        
        source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE,UInt(fileDescriptor),DISPATCH_VNODE_WRITE,dispatch_get_main_queue())
        //source = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, UInt(fileDescriptor), DISPATCH_VNODE_WRITE, dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT))
        dispatch_source_set_event_handler(source, { dispatch_async(dispatch_get_main_queue(), block) })
        dispatch_resume(source)
    }
    
    //
    
    private let fileDescriptor: CInt
    private let source: dispatch_source_t
}

public class FileSystemWatcher {
    
    // MARK: - Initialization / Deinitialization
    
    public init(pathsToWatch: [String], sinceWhen: FSEventStreamEventId) {
        self.lastEventId = sinceWhen
        self.pathsToWatch = pathsToWatch
    }
    
    convenience public init(pathsToWatch: [String]) {
        self.init(pathsToWatch: pathsToWatch, sinceWhen: FSEventStreamEventId(kFSEventStreamEventIdSinceNow))
    }
    
    deinit {
        stop()
    }
    
    // MARK: - Private Properties
    
    private let eventCallback: FSEventStreamCallback = { (stream: ConstFSEventStreamRef, contextInfo: UnsafeMutablePointer<Void>, numEvents: Int, eventPaths: UnsafeMutablePointer<Void>, eventFlags: UnsafePointer<FSEventStreamEventFlags>, eventIds: UnsafePointer<FSEventStreamEventId>) in
        Swift.print("***** FSEventCallback Fired *****", terminator: "\n")
        
        let fileSystemWatcher: FileSystemWatcher = unsafeBitCast(contextInfo, FileSystemWatcher.self)
        let paths = unsafeBitCast(eventPaths, NSArray.self) as! [String]
        
        for index in 0..<numEvents {
            fileSystemWatcher.processEvent(eventIds[index], eventPath: paths[index], eventFlags: eventFlags[index])
        }
        
        fileSystemWatcher.lastEventId = eventIds[numEvents - 1]
    }
    private let pathsToWatch: [String]
    private var started = false
    private var streamRef: FSEventStreamRef!
    
    // MARK: - Private Methods
    
    private func processEvent(eventId: FSEventStreamEventId, eventPath: String, eventFlags: FSEventStreamEventFlags) {
        Swift.print("\t\(eventId) - \(eventFlags) - \(eventPath)", terminator: "\n")
    }
    
    // MARK: - Pubic Properties
    
    public private(set) var lastEventId: FSEventStreamEventId
    
    // MARK: - Pubic Methods
    
    public func start() {
        guard started == false else { return }
        
        var context = FSEventStreamContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil)
        context.info = UnsafeMutablePointer<Void>(unsafeAddressOf(self))
        let flags = UInt32(kFSEventStreamCreateFlagUseCFTypes | kFSEventStreamCreateFlagFileEvents)
        streamRef = FSEventStreamCreate(kCFAllocatorDefault, eventCallback, &context, pathsToWatch, lastEventId, 0, flags)
        
        FSEventStreamScheduleWithRunLoop(streamRef, CFRunLoopGetMain(), kCFRunLoopDefaultMode)
        FSEventStreamStart(streamRef)
        
        started = true
    }
    
    public func stop() {
        guard started == true else { return }
        
        FSEventStreamStop(streamRef)
        FSEventStreamInvalidate(streamRef)
        FSEventStreamRelease(streamRef)
        streamRef = nil
        
        started = false
    }
    
}
