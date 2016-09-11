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
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/button/button.css")
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        Swift.print("StyleManager.styleTree.keys: " + "\(StyleManager.styleTree.keys)")
        //let startTime = NSDate()
        //createComponents()
        let selectors:[ISelector] = [Selector("Button",[],"",[])]//Selector("Window",[],""),Selector("List",[],""),
        let element:IElement = Button(100,20)
        let style = StyleResolver.style2(selectors,element)
        style.describe()
        /*
        for var i = 0; i < 2000; ++i{
            
        }
        */
        //Swift.print("time: " + "\(abs(startTime.timeIntervalSinceNow))")
        //Swift.print("StyleResolver.styleLookUpCount: " + "\(StyleResolver.styleLookUpCount)")
        
        //StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        //win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

