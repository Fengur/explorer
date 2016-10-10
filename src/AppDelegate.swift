import Cocoa
/**
 * This is the main class for the application
 * TODO: Start making the 1-column GitSync Interface (with text buttons on the bottom first)
 * TODO: Implement the Other and Advance wins (Group the scattered css styles into a unified other.css and advance.css)
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        win = TranslucencyWin()
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

//example of how to implement "Live-reload" of styles:

/*
StyleManager.addStylesByURL("~/Desktop/css/treelistdemo.css")
StyleManager.addStylesByURL("~/Desktop/ElCapitan/advance/treelist/treelist.css")
//StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/slider/vslider.css")
let url:String = "~/Desktop/ElCapitan/advance/treelist/slidertreelist.css"
StyleManager.addStylesByURL(url,true)


fileWatcher = FileWatcher([url.tildePath])
fileWatcher!.event = { event in
//Swift.print(self)
Swift.print(event.description)
if(event.fileChange && event.path == url.tildePath) {
StyleManager.addStylesByURL(url,true)
ElementModifier.refreshSkin(self)
ElementModifier.floatChildren(self)
}
}
fileWatcher!.start()
*/