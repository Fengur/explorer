import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/button/button.css")
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        //win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        //NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        reflectionTest()
    }
    /**
     *
     */
    func reflectionTest(){
        let selector:ISelector = Selector("Button",[],"id",[])
        let xml:XML = selector.toXML(selector)
        xml.string//.XMLString
        Swift.print("xml.string: " + "\(xml.string)")
        Swift.print("xml.XMLString: " + "\(xml.XMLString)")
    }
    /**
     * Testing
     */
    func styleTest(){
        //let startTime = NSDate()
        let selectors:[ISelector] = [Selector("Window",[],""),Selector("List",[],""),Selector("Button",[],"",[])]//
        let style = StyleResolver.style2(selectors)
        style.describe()

        //Swift.print("time: " + "\(abs(startTime.timeIntervalSinceNow))")
        Swift.print("StyleResolver.styleLookUpCount: " + "\(StyleResolver.styleLookUpCount)")
    
        for var i = 0; i < 2000; ++i{
            
        }
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

