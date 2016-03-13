import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        StyleManager.addStyle("Window{fill:#EFEFF4;corner-radius:4px;}Button{fill:blue;}")//<--you should target a bg element not the window it self, since now everything inherits these values
        win = Win(1000,800)
        
        
        //Continue here:
        
        //create 2 styles 
        
        //use resolveStyle
        
        
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}

