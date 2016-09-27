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
        
        
        //IMPORTANT: So its not the retrival of the styles that is slow. Although making it 30x faster with the tail trick is nice!

        //styleReflection()
        //typeAssertion()
        //wrapUnWrapDropShadowTest()
        
        //Continue here: test unWrapping Gradient , StyleProperty, Selector and then Style, then try to store many stylesand respawn many styles
        
    }
    /**
     *
     */
    func wrapUnWrapGradientTest(){
        //1. Create an instance
        let instance = LinearGradient(Gradients.deepPurple(),[0,1])
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        //3. unWrap the XML to a new instance
        let newInstance:LinearGradient? = LinearGradient.unWrap(xml)
        //4. compare the two instances
        if(ArrayAsserter.equals(instance.colors, newInstance!.colors) && ArrayAsserter.equals(instance.locations, newInstance!.locations) && instance.rotation == newInstance!.rotation){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
        
        //UNwrap in Gradient is missing transformation. add it
        
    }
    /**
     * Test If you can UnWrap DropShadow, then add UInt,Float,Double,Int etc
     */
    func wrapUnWrapDropShadowTest(){
        //1. Create a DropShadow instance
        let dropShadow = DropShadow(NSColor.blackColor(),0,0,2,false)
        //2. reflect the dropshadow instance to XML
        let xml = Reflection.toXML(dropShadow)
        //Swift.print(xml.string)
        //3. unWrap the XML to a new dropshadow instance
        let newDropShadow:DropShadow? = DropShadow.unWrap(xml)
        //4. compare the two dropshadow instances
        Swift.print("newDropShadow!.color: " + "\(newDropShadow!.color.hexString)")
        Swift.print("dropShadow.color: " + "\(dropShadow.color.hexString)")
        Swift.print("newDropShadow!.blurRadius: " + "\(newDropShadow!.blurRadius)")
        Swift.print("dropShadow.blurRadius: " + "\(dropShadow.blurRadius)")
        if(newDropShadow!.color.hexString == dropShadow.color.hexString && newDropShadow!.blurRadius == dropShadow.blurRadius){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
        
        
    }
    /**
     *
     */
    func typeAssertion(){
        
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
        
        // and add an Ems() type (EMS isn't used alot if at all so don't worry about that for the moment)
        // and you need to test converting Gradient to xml
        
        
        //Continue here: Time to see if you can recreate the Style from xml! (first do this with StyleProperty, and assert that this stil works with the Selector)
        //Also take a look at Unwrap repo on github how sundval does it
        

        //let selector = Selector("Window",[],"special",["focus"])
        //let selector2 = Selector("Button",[],"custom",["over"])
        //let dropShadow = DropShadow(NSColor.blackColor(),0,0,2,false)
        //let gradient = LinearGradient(Gradients.teal(0.5),[],π/2)//
        let gradient2 = RadialGradient(Gradients.teal(0.5),[],π/2)//
        //let color = NSColorParser.nsColor(0xFF0000)
        let styleProperty = StyleProperty("fill",gradient2/*color*/,0)
        //let styleProperty2 = StyleProperty("line",NSColorParser.nsColor(0x0000FF),0)
        //let styleProperty3 = StyleProperty("dropShadow",dropShadow,0)
        
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

