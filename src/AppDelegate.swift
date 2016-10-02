import Cocoa
/**
 * This is the main class for the application
 * TODO: Maybe not store xml nodes that are empty, or arrays that has no items. 6000 lines of xml is a bit excesive
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    static var selectorsString:String = ""
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/button/button.css")

        /**/
        //let startTime = NSDate()
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        //Swift.print("Adding basic styles time: " + "\(abs(startTime.timeIntervalSinceNow))")
        
        readXMLFromDisk()
        win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        /**/
        

        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //wrappingtests()
        /*
        let startTime2 = NSDate()
        //writeXMLToDisk()
        Swift.print("Storing styles time: " + "\(abs(startTime2.timeIntervalSinceNow))")//0.29sec for basic styles, pretty good!
        */
    }
    func writeXMLToDisk(){
        var contentToWriteToDisk = "<data>"
        //Swift.print("StyleManager.styles.count: " + "\(StyleManager.styles.count)")
        StyleManager.styles.forEach{
            let xml = Reflection.toXML($0)
            contentToWriteToDisk += xml.XMLString
            //Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        }
        contentToWriteToDisk += "</data>"//wrap the selector in an selectors root xml
        FileModifier.write("~/Desktop/styles.xml".tildePath, contentToWriteToDisk)//<--wrong name should be styles.xml
    }
    func readXMLFromDisk(){
        let startTime = NSDate()
        let xml:XML = FileParser.xml("~/Desktop/styles.xml".tildePath)//then try toload this selectors.xml and convert every selector into Selector instancces in an array
        var styles:[IStyle] = []
        Swift.print("xml.children?.count: " + "\(xml.children?.count)")
        xml.children?.forEach{
            let style:Style? = Style.unWrap($0 as! XML)
            if(style != nil) {styles.append(style!)}
        }
        Swift.print("styles.count: " + "\(styles.count)")//then check the count
        Swift.print("parse xml time: " + "\(abs(startTime.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors
        let startTime2 = NSDate()
        StyleManager.addStyle(styles)
        Swift.print("addStyle time: " + "\(abs(startTime2.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors

    }
    
    /**
     * TODO: see if you can recreate the Style from xml! (first do this with StyleProperty, and assert that this stil works with the Selector)
     * TODO: and add an Ems() type (EMS isn't used alot if at all so don't worry about that for the moment)
     */
    func wrappingtests(){
        //reflectionTest()
      
        //IMPORTANT: So its not the retrival of the styles that is slow. Although making it 30x faster with the tail trick is nice!
       
        //Continue here: StyleProperty, Selector and then Style, then try to store many styles and respawn many styles
        //styleReflection()
        //typeAssertion()
        //dropShadowTest()
        //gradientTest()
        //stylePropertyTest()
        //selectorTest()
        //styleTesting()
    }
    /**
     *
     */
    func styleTesting(){
        //1. Create an instance
        let selector = Selector("Window",[],"special",["focus"])
        let selector2 = Selector("Button",[],"custom",["over"])
        let dropShadow = DropShadow(NSColor.blackColor(),0,0,2,false)
        //let gradient = LinearGradient(Gradients.teal(0.5),[],π/2)//
        let gradient2 = RadialGradient(Gradients.teal(0.5),[],π/2)//
        //let color = NSColorParser.nsColor(0xFF0000)
        let styleProperty = StyleProperty("fill",gradient2/*color*/,0)
        let styleProperty2 = StyleProperty("line",NSColorParser.nsColor(0x0000FF),0)
        let styleProperty3 = StyleProperty("dropShadow",dropShadow,0)
        
        let instance:Style = Style("custom",[selector,selector2],[styleProperty,styleProperty2,styleProperty3])
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        //3. unWrap the XML to a new instance
        let newInstance:Style? = Style.unWrap(xml)
        //Swift.print("newInstance?.name: " + "\(newInstance?.name)")
        //4. compare the two instances (Naive assert)
        if(instance.name == newInstance!.name && instance.selectors.count == newInstance!.selectors.count && instance.styleProperties.count == newInstance!.styleProperties.count){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
    }
    /**
     *
     */
    func selectorTest(){
        //1. Create an instance
        let instance:Selector = Selector("Window",[],"special",["focus"])
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        //3. unWrap the XML to a new instance
        let newInstance:Selector? = Selector.unWrap(xml)
        //4. compare the two instances
        if(instance.id == newInstance!.id && instance.element == newInstance!.element && ArrayAsserter.equals(instance.states, newInstance!.states) && ArrayAsserter.equals(instance.classIds, newInstance!.classIds)){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
    }
    /**
     *
     */
    func stylePropertyTest(){
        //1. Create an instance
        //let color = NSColorParser.nsColor(0xFF0000)
        let padding:[Any] = [CGFloat(2.0),CGFloat(4.0),CGFloat(1.0),CGFloat(3.0)]
        let instance = StyleProperty("padding",padding,0)
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        //3. unWrap the XML to a new instance
        let newInstance:StyleProperty? = StyleProperty.unWrap(xml)
        //4. compare the two instances (Naive assert)
        if(instance.name == newInstance!.name && instance.depth == newInstance!.depth){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
        Swift.print("newInstance!.value: " + "\(newInstance!.value)")
        
        /*
        let c:Any?  = NSColor.redColor()
        Swift.print("c: " + "\(c)")
        Swift.print("c is NSColor: " + "\(c is NSColor)")
        let cCopy:NSColor = c as! NSColor
        Swift.print("cCopy: " + "\(cCopy)")
        
        */
        
    }
    /**
     * Test unWrapping Gradient (LinearGradient,RadialGradient)
     */
    func gradientTest(){
        //1. Create an instance
        let instance = RadialGradient(Gradients.deepPurple(),[0,1])//LinearGradient
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.XMLString)")
        //3. unWrap the XML to a new instance
        let newInstance:RadialGradient? = RadialGradient.unWrap(xml)
        Swift.print("newInstance: " + "\(newInstance)")
        Swift.print("newInstance?.colors: " + "\(newInstance?.colors)")
        Swift.print("newInstance?.locations: " + "\(newInstance?.locations)")
        Swift.print("newInstance?.rotation: " + "\(newInstance?.rotation)")
        Swift.print("newInstance?.transformation: " + "\(newInstance?.transformation)")
        //4. compare the two instances (Naive assert)
        if(/*ArrayAsserter.equals(instance.colors, newInstance!.colors) &&*/ ArrayAsserter.equals(instance.locations, newInstance!.locations) && instance.rotation == newInstance!.rotation){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
    }
    /**
     * Test If you can UnWrap DropShadow, then add UInt,Float,Double,Int etc
     */
    func dropShadowTest(){
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
            
            let selector:ISelector = Selector.unWrap(xml)!
            let selectorString:String = SelectorParser.selectorString(selector)
            Swift.print("selectorString: " + "\(selectorString)")
        }
        //inputTest()
        /**
         * NOTE: stores the xml string to disk.
         * NOTE: collect all selectors in one string, and then after the app has initialized, you need to save this string to disk
         */
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
                    let selector:ISelector = Selector.unWrap(subChild)!
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

