import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/window.css")
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/card.css")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        StyleManager.hashedStyles = Utils.groupBy(StyleManager.styles, f: { $0.selectors.count.string })
        //StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

