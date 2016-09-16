import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    static var selectorsString:String = ""
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/button/button.css")
        
        let str = "abc def ghij"
        let matches = RegExp.matches(str, "\\w{3}")
        for match:NSTextCheckingResult in matches {
            Swift.print("match.numberOfRanges: " + "\(match.numberOfRanges)")
            let content = (str as NSString).substringWithRange(match.rangeAtIndex(0))/*the entire match*/
            Swift.print("content: " + "\(content)")
            let name = (str as NSString).substringWithRange(match.rangeAtIndex(1))/*capturing group 1*/
            Swift.print("name: " + "\(name)")
            //let properties = (str as NSString).substringWithRange(match.rangeAtIndex(2))/*capturing group 2*/
        }
        
        /*
        
        let startTime = NSDate()
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        Swift.print("Adding basic styles time: " + "\(abs(startTime.timeIntervalSinceNow))")
        win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        
        */
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        //reflectionTest()
        
        
        //Continue here: So its not the retrival of the styles that is slow. Although making it 30x faster is nice!
        //then it could either be drawing of may graphics elements, creating many nsviews, or gathering inheritance info
        
        //test creating many NSViews
        
        //actually: try to create 200 Buttons with basic style and add them to a window. 200 buttons at: 10px by 10px in size With the same style
        
    }
    /**
     * NOTE: records all elementSelectors used and store them in a string then try to request all styles
     * NOTE: saves all complete styles as they are created. Store to disk
     */
    func reflectionTest(){
        func outputTest(){//From selector to xml
            let selector:ISelector = Selector("Button",[],"custom",["over","down"])/*"special","custom"*/
            let xml:XML = Reflection.toXML(selector)
            Swift.print(xml.string)
        }
        //outputTest()

        func inputTest(){//from XML to selector
            let xmlStr:String = "<Selector><element type=\"String\">Button</element><classIds type=\"Array\"></classIds><id type=\"String\">custom</id><states type=\"Array\"><item type=\"String\">over</item><item type=\"String\">down</item></states></Selector>"
            let xml:XML = xmlStr.xml
            
            Swift.print("xml.XMLString: " + "\(xml.XMLString)")
            Swift.print("xml.children!.count: " + "\(xml.children!.count)")
            let test = XMLParser.childAt(xml.children!, 0)!.value
            Swift.print("test: " + "\(test)")
            
            let selector:ISelector = Selector.selector(xml)
            let selectorString:String = SelectorParser.selectorString(selector)
            Swift.print("selectorString: " + "\(selectorString)")
        }
        //inputTest()
        
        //continue here: store the xml string to disk.
        //you need to collect all selectors in one string, and then after the app has initialized, you need to save this string to disk
        
        func writeToDisk(){
            let contentToWriteToDisk = "<data>" + AppDelegate.selectorsString + "</data>"//wrap the selector in an selectors root xml
            FileModifier.write("~/Desktop/selectors.xml".tildePath, contentToWriteToDisk)
        }
        
        func readFromDisk()->[[ISelector]]{
            let xml:XML = FileParser.xml("~/Desktop/selectors.xml".tildePath)//then try toload this selectors.xml and convert every selector into Selector instancces in an array
            var data:[[ISelector]] = []
            xml.children?.forEach{
                var selectors:[ISelector] = []
                let child:XML = $0 as! XML
                child.children?.forEach{
                    let subChild:XML = $0 as! XML
                    let selector:ISelector = Selector.selector(subChild)
                    selectors.append(selector)
                }
                data.append(selectors)
            }
            Swift.print("data.count: " + "\(data.count)")//then check the count
            return data
        }
        let data = readFromDisk()
        let startTime = NSDate()
        var styles:[IStyle] = []
        data.forEach{
            let style:IStyle = StyleResolver.style($0, nil/*Text(100,20)*/)
            styles.append(style)//then use the StyleResolver to resolve every selector
        }
        Swift.print("styles.count: " + "\(styles.count)")
        Swift.print("time: " + "\(abs(startTime.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors

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

