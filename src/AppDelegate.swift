import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        /**/
        StyleManager.addStylesByURL("~/Desktop/css/window.css")
        //StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        win = TranslucencyWin()//Win(1000,800)
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/

        
        //continue here: test hsb2
        //testingHSB2()
        
        //Swift.print("-60 % 360: " + "\(360 % -60)")
        
        //testingHSB()
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

