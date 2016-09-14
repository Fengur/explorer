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
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        reflectionTest()
    }
    /**
     *
     */
    func reflectionTest(){
        /*
        //From selector to xml
        let selector:ISelector = Selector("Button",[],"custom",["over","down"])/*"special","custom"*/
        let xml:XML = Reflection.toXML(selector)
        Swift.print(xml.string)
        */
        
        //from XML to selector
        let xmlStr:String = "<p>text</p>"//"<Selector><element type=\"String\">Button</element><classIds type=\"Array\"></classIds><id type=\"String\">custom</id><states type=\"Array\"><0 type=\"String\">over</0><1 type=\"String\">down</1></states></Selector>"
        let newXML:XML = xmlStr.xml
        Swift.print("newXML.XMLString: " + "\(newXML.XMLString)")
        //let test:String = (newXML.children![0] as! XML).value
        //Swift.print("test: " + "\(test)")
        /*
        
        let newSelector:ISelector = Selector.selector(newXML)
        let selectorString:String = SelectorParser.selectorString(newSelector)
        Swift.print("selectorString: " + "\(selectorString)")
        */
        //continue here
        
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

