import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--this is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        StyleManager.addStyle("Window Element#background{fill:#EFEFF4;corner-radius:4px;}")//<--you should target a bg element not the window it self, since now everything inherits these values
        win = Win(300,300)
        NSApp.windows[0].close()/*close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}

