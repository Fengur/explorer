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
        StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        win = TranslucencyWin()//Win(1000,800)
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //continue here: try to convert an rgb to an hsb and then back again
        
    }
    /**
     * NOTE: tests rgb.nsCOlor and nsCOlor.hexString for the regular colors. whats wrong?
     */
    func colorTesting(){
        let red:String = "0xFF0000"
        //let green:String = "0x00FF00"
        //let blue:String = "0x0000FF"
        
        let r:NSColor = NSColorParser.nsColor(red)
        let redRGB = r.rgb
        Swift.print("redRGB.r: " + "\(redRGB.r)")
        Swift.print("redRGB.g: " + "\(redRGB.g)")
        Swift.print("redRGB.b: " + "\(redRGB.b)")
        
        let tempColor = NSColorParser.nsColor(redRGB)
        Swift.print("tempColor.redComponent: " + "\(tempColor.redComponent)")
        Swift.print("tempColor.greenComponent: " + "\(tempColor.greenComponent)")
        Swift.print("tempColor.blueComponent: " + "\(tempColor.blueComponent)")
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        print("Good-bye")
    }
}

