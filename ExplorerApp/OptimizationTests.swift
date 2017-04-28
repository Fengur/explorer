import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: Maybe not store xml nodes that are empty, or arrays that has no items. 6000 lines of xml is a bit excesive
 */
class OptimizationTests {

    func notes(){
        //Continue here: It's the loading of the styles that is slow. either loading a file it self or adding to styleManger
        //To speed things up: all you have to do is populate explorer.css with all the css for all components in basic, advance and other and toggle them like in legacy code
        //to speed things up further: more enums/structs smarter loops etc.
        //you should be able to get to bellow 1 sec for basic components. Which is pretty good.Then by just making the code better this will go even further down
        //the big time hog is the resolvment of the styles, this can be fixed with the new idea about not looking up all styles for every addition but skipping styles the has been absorbed by other more spesific styles, basicly a more efficient resolvment algo (1-days work probably)
        
        //Start drawing the speedier style retrival system out on postits. get a grip of the concept, test things in your mind first.
        //you could also try to save all style requests in a textFile, then load them via an xml doc. Then hi-jack stylemanager to use a dictionary with absolute styles for everything, just to see the speed and know what to aim for
        //add this to the css classes: http://nshipster.com/swift-comparison-protocols/
        
        //Swift.print("StyleResolver.styleLookUpCount: " + "\(StyleResolver.styleLookUpCount)")
        
        //buttonTest()
        
        /*
         let lineStyle = LineStyle(1,NSColor.blackColor(),CGLineCap.Butt,CGLineJoin.Miter,10,0,[2,2])
         
         /*Rect*/
         let rect = RectGraphic(40,40,200,200,nil,lineStyle)
         addSubview(rect.graphic)
         rect.draw()*/

    }
    /**
     * NOTE: it takes 0.44sec to make 144 buttons (the same with gradient applied)
     */
    func buttonTest(){
        let buttonStyle:String = "Container#main Button{fill:linear-gradient(top,red,blue);float:left;}Button#clear{clear:left;}"
        StyleManager.addStyle(buttonStyle)
        for i in 0..<144{
            let id:String = i % 12 == 0 ? "clear" : ""//the 13th element drops down bellow
            _ = id
            //_ = container.addSubView(Button(24,24,container,id))
        }
    }
    /**
     * remove this when it works
     */
    func styleCacheTest(){
        
        let dataXML = "<data></data>".xml
        let styles = "<styles></styles>".xml
        dataXML.appendChild(styles)
        let cssFileDatesXML = StyleCache.cssFileDates()
        dataXML.appendChild(cssFileDatesXML)
        
        
        
        //Continue here: you need to figure out how to get the import urls from the querried css with out loading the styles.
        //As you need the import urls from the source of the query and not the cache
        let queryURL = "~/Desktop/ElCapitan/explorer.css"//you need to do is to check if this url is up to date, as this may change from the usres pov
        let cssFileDateList = StyleCache.cssFileDateList(dataXML)
        let hasBeenCached:Bool = StyleCache.hasFileBeenCached(cssFileDateList, queryURL)
        Swift.print("hasBeenCached: " + "\(hasBeenCached)")
        let isUpToDate = StyleCache.isUpToDate(cssFileDateList)
        Swift.print("isUpToDate: " + "\(isUpToDate)")
    }
    /**
     *
     */
    func selectorDebugTest(){
        let selectors:[ISelector] = [Selector("Window")]
        let style = StyleResolver.style(selectors, nil)
        style.describe()
    }
    /**
     *
     */
    func rgbaColorTests(){
        let color = NSColor.purple.alpha(0.5)
        Swift.print("color.hexString: " + "\(color.hexString)")
        //let rgba = RGBAParser.rgba(color)
        //rgba
        let hex:String = RGBAParser.hex(color)
        Swift.print("hex: " + "\(hex)")
        //HexParser.hexValue(255,255,255,100)
        /*
        let a:UInt = 0xFF0000FF
        Swift.print("a: " + "\(a)")
        let b:UInt = UInt(Double("0xFF0000FF")!)
        Swift.print("b: " + "\(b)")
        */
        let newRGBA:RGBA = RGBAParser.rgba32(UInt(Double("0x" + hex)!))
        Swift.print("newRGBA.b: " + "\(newRGBA.b)")
        Swift.print("newRGBA.a: " + "\(newRGBA.a)")
        let newColor:NSColor = newRGBA.nsColor
        Swift.print("newColor.hexString: " + "\(newColor.hexString)")
        Swift.print("newColor.alphaComponent: " + "\(newColor.alphaComponent)")
    }
    /**
     * TODO: see if you can recreate the Style from xml! (first do this with StyleProperty, and assert that this stil works with the Selector)
     * TODO: and add an Ems() type (EMS isn't used alot if at all so don't worry about that for the moment)
     */
    func wrappingtests(){
        //reflectionTest()
        
        //IMPORTANT: So its not the retrival of the styles that is slow. Although making it 30x faster with the tail trick is nice!
        
        
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
        let dropShadow = DropShadow(NSColor.black,0,0,2,false)
        
        //continue here: dropshadow is showing up as a string when reflecting it.. figure it out
        
        Swift.print("dropShadow.dynamicType: " + "\(type(of:dropShadow))")
        //let gradient = LinearGradient(Gradients.teal(0.5),[],π/2)//
        let gradient2 = RadialGradient(Gradients.teal(0.5),[],π/2)//
        //let color = NSColorParser.nsColor(0xFF0000)
        let styleProperty = StyleProperty("fill",gradient2/*color*/,0)
        let styleProperty2 = StyleProperty("line",NSColorParser.nsColor(0x0000FF),0)
        let styleProperty3 = StyleProperty("dropShadow",dropShadow,0)
        
        let instance:Style = Style("custom",[selector,selector2],[styleProperty,styleProperty2,styleProperty3])
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.xmlString)")
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
        /*
         
         Out of order, could be an issue with Element beeing a Framework and a class
         
        //1. Create an instance
        let instance:Selector = Selector("Window",[],"special",["focus"])
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.xmlString)")
        //3. unWrap the XML to a new instance
        let newInstance:Selector = Selector.unWrap(xml)
        //4. compare the two instances
        if(instance.id == newInstance!.id && instance.element == newInstance!.element && ArrayAsserter.equals(instance.states, newInstance!.states) && ArrayAsserter.equals(instance.classIds, newInstance!.classIds)){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
        */
    }
    /**
     *
     */
    func stylePropertyTest(){
        
        //Continue here: try to add paddingLeft: 2.0 as a cgfloat see if the value is optional, if it is try to fix it.
        
        //1. Create an instance
        //let color = NSColorParser.nsColor(0xFF0000)
        //let padding:[Any] = [CGFloat(2.0),CGFloat(4.0),CGFloat(1.0),CGFloat(3.0)]
        
        //let cgFloat:CGFloat = 4.0
        let dropShadow = DropShadow(NSColor.green,0,0,2,false)
        let instance = StyleProperty("dropshadow",dropShadow,0)
        //2. reflect the instance to XML
        let xml = Reflection.toXML(instance)
        Swift.print("xml.XMLString: " + "\(xml.xmlString)")
        //3. unWrap the XML to a new instance
        let newInstance:StyleProperty? = StyleProperty.unWrap(xml)
        //4. compare the two instances (Naive assert)
        if(instance.name == newInstance!.name && instance.depth == newInstance!.depth){
            Swift.print("is Equal")
        }else{
            Swift.print("is not equal")
        }
        Swift.print("newInstance!.value: " + "\(newInstance!.value)")
        Swift.print("newInstance!.value.dynamicType: " + "\(type(of: newInstance!.value))")
        
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
        Swift.print("xml.XMLString: " + "\(xml.xmlString)")
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
        let dropShadow = DropShadow(NSColor.black,0,0,2,false)
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
        if(transform != nil){Swift.print("transform!.dynamicType: " + "\(type(of: transform!))")}
        Swift.print("transform.dynamicType: " + "\(type(of: transform))")
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
            
            Swift.print("xml.XMLString: " + "\(xml.xmlString)")
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
        func writeSelectorsToDisk(){
            let contentToWriteToDisk = "<data>" + StyleResolver.selectorsString + "</data>"//wrap the selector in an selectors root xml
            _ = FileModifier.write("~/Desktop/selectors.xml".tildePath, contentToWriteToDisk)
        }
        func readSelectorsFromDisk()->[[ISelector]]{
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
        let startTime1 = NSDate()
        let data = readSelectorsFromDisk()
        Swift.print("read SelectorsFromDisk time: " + "\(abs(startTime1.timeIntervalSinceNow))")
        let startTime = NSDate()
        var styles:[IStyle] = []
        data.forEach{
            let style:IStyle = StyleResolver.style($0, nil/*Text(100,20)*/)
            styles.append(style)//then use the StyleResolver to resolve every selector
        }
        Swift.print("styles.count: " + "\(styles.count)")
        Swift.print("style retrival time: " + "\(abs(startTime.timeIntervalSinceNow))")//then try to measure the time of resolving all selectors
        
    }
    /**
     * Testing
     */
    func styleTest(){
        //let startTime = NSDate()
        /*let selectors:[ISelector] = [Selector("Window",[],""),Selector("List",[],""),Selector("Button",[],"",[])]//
         let style = StyleResolver.style2(selectors)
         style.describe()
         
         //Swift.print("time: " + "\(abs(startTime.timeIntervalSinceNow))")
         Swift.print("StyleResolver.styleLookUpCount: " + "\(StyleResolver.styleLookUpCount)")
         
         for i in 0 ..< 2000{
         _ = i
         }*/
    }
    /**
     *
     */
    func cssTest(){
        StyleManager.addStyle("Container Button{thickness:30px;}Container Container Container Container Button{thickness:20px;}Container Container Button{thickness:10px;}")
        let a = Container(100,100)
        let b = a.addSubView(Container(100,100,a))
        let c = b.addSubView(Container(100,100,b))
        _ = c
        //let btn = Button(100,20)
        let btn2 = a.addSubView(Button(100,20,a))
        let props = btn2.skin?.style?.getStyleProperties("thickness")
        Swift.print("thickness: " + "\(props?.first?.value)")
        
        
    }
}
