import Cocoa
@testable import Element
@testable import Utils

//Continue here: 🏀
    //add the extracted componets as standalone packages to Element explorer (later)
    //Design GitSync v3 in illustrator 👈
    //Better window-dropshadow 👈
    //More consts to enum
    //More code refactoring


@NSApplicationMain
class AppDelegate:NSObject,NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //Insert code here to initialize your application
        //print(ArrayParser.difference([1,2], [1]))
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        //Swift.print("after css")
       // win = RegularWin()//TranslucencyWin()
        
        //cssTest()
        
        
        win = 	NSWindow()
        let	view1	=	NSView()
        
        
            win?.setFrame(CGRect(x: 400, y: 0, width: 400, height: 500), display: true)
            win?.contentView					=	view1
            
            win?.backgroundColor				=	.clear
            win?.isOpaque						=	false
            win?.styleMask					=	[.borderless , .resizable]
            win?.isMovableByWindowBackground	=	true
            win?.makeKeyAndOrderFront(self)
            
            view1.wantsLayer				=	true
            view1.layer?.cornerRadius		=	10
            view1.layer?.backgroundColor	=	NSColor.white.cgColor
            
            ///	:ref:	http://stackoverflow.com/questions/19940019/nswindow-with-round-corners-and-shadow/27613308#21247949
            win?.invalidateShadow()	//	This manual invalidation is REQUIRED because shadow generation is an expensive operation.
        
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        // Insert code here to tear down your application
    }
}
