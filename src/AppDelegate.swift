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
        
        
        
        /*
        let startTime = NSDate()
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        Swift.print("Adding basic styles time: " + "\(abs(startTime.timeIntervalSinceNow))")
        win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        */

        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        //reflectionTest()
        
        
        //Continue here: So its not the retrival of the styles that is slow. Although making it 30x faster is nice!

        //styleReflection()
        typeAssertion()
        
        //Swift.print("NSColor.redColor().cgColor is Reflectable: " + "\(NSColor.redColor().cgColor is Reflectable)")
        
        /**/
        //Continue here: figure out how to reflect  CGAffineTransform. first you need to create a test to figure out how to assert the "is CGAffineTransform" assert
        
        //Actually, for special types like CGAffineTransform etc, you should make an protocol named: Reflectable that you extend CGColor CGTransform etc. that package these types into an organized xml child
        //Then all you do is:
        
        
        //CGAffineTranform optional isnt being detected, nore is the CGColor, try to make an isolated test and see if it works
        
    }
    /**
     *
     */
    func typeAssertion(){
        
        //Continue here: Try to get the type of CGTransform that is nil. Might need to use RegExp, Check stackoverflow etc
        /*
        let cgColor:CGColorRef = NSColor.redColor().cgColor
        let tempVar:Any = cgColor
        Swift.print("tempVar is Reflectable: " + "\(tempVar is Reflectable)")
        let temp:[Any] = [NSColor.redColor().cgColor]
        let isCGColor = temp[0] as? Reflectable != nil
        Swift.print("temp[0].dynamicType: " + "\(temp[0].dynamicType)")
        Swift.print("isCGColor: " + "\(isCGColor)")
        
        
        /**/
        if CFGetTypeID(tempVar as! AnyObject) == CGColorGetTypeID() {
            let reflectable:Reflectable = tempVar as! CGColorRef
            Swift.print("reflectable: " + "\(reflectable.reflection.value)")
            Swift.print("found CGColor")
        }
        */
        
        let transform:Any? = CGAffineTransform.init()
        if(transform != nil){Swift.print("transform!.dynamicType: " + "\(transform!.dynamicType)")}
        Swift.print("transform.dynamicType: " + "\(transform.dynamicType)")
        Swift.print("transform is CGAffineTransform: " + "\(transform is CGAffineTransform)")
        Swift.print("transform is Reflectable: " + "\(transform is Reflectable)")
    }
    /**
     *
     */
    func styleReflection(){
        //Reflection design of Style:

        //<Style name="">
            //<Selectors><Selectors>
            //<StyleProperties>
                //<item type="StyleProperty">
                    //<name>fill</name>
                    //<value type=UInt>red</value>
                    //<depth>1</depth>
                //</item>
            //</StyleProperties>
        //</Style>
        
        //continue here: converting to xml now works. Next is converting from xml to Style,styleProperty and Selector
        //See ISelector for how this can be accomplised, its basically traversing xml, easy!!!
        
        
        // and add an Ems() type (EMS isnt used alot if at all so dont worry about that for the moment)
        // and you need to test converting Gradient to xml
        
        
        //Continue here: Test if you can get NSColor working with reflecting a style, then gradient, the dropshadow etc, TextFormat isn't imp atm since its not used as a css value much if at all
        

        //let selector = Selector("Window",[],"special",["focus"])
        //let selector2 = Selector("Button",[],"custom",["over"])
        let gradient = LinearGradient(Gradients.teal(0.5),[],π/2)//
        //let color = NSColorParser.nsColor(0xFF0000)
        let styleProperty = StyleProperty("fill",gradient/*color*/,0)
        //let styleProperty2 = StyleProperty("line",NSColorParser.nsColor(0x0000FF),0)
        let style:IStyle = Style("",[/*selector,selector2*/],[styleProperty/*styleProperty1*/])
        
        /*let properties = Reflection.reflect(styleProperty)
        properties.forEach{
            Swift.print("$0.label: " + "\($0.label)")
            Swift.print("$0.value: " + "\($0.value)")
            Swift.print("$0.value.dynamicType: " + "\($0.value.dynamicType)")
          
        }*/
        let xml:XML = Reflection.toXML(style)
        Swift.print(xml.string)
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

