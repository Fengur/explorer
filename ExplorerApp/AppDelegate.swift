import Cocoa
@testable import Element
@testable import Utils


@NSApplicationMain
class AppDelegate:NSObject,NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {/*Insert code here to initialize your application*/
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        //win = RegularWin()//
        win = VibrantWin(1000,800)
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        // Insert code here to tear down your application
    }
}
