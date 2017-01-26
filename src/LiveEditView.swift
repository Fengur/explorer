import Cocoa

class LiveEditView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    var temp:String = "123"
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //liveEditTest1()
        //liveEditTest2()
        //liveEditTest3()
        //fileWatchTest()
        
    }
    /**
     *
     */
    func fileWatchTest() {
        fileWatcher = FileWatcher(["~/Desktop/test/".tildePath],FSEventStreamEventId(kFSEventStreamEventIdSinceNow))
        fileWatcher!.event = { [weak self] event in
            self?.temp
            Swift.print(event.description)
        }
        fileWatcher!.start()
        self.temp += "abc"
    }
    /**
     *
     */
    func liveEditTest1() {
        StyleManager.addStyle("#redBox{fill:red;float:left;clear:left;}")
        let redBox = addSubView(Element(100,100,self,"redBox"))
        
        StyleManager.addStyle("#btn1{fill:green;float:left;clear:left;}")
        let btn = addSubView(Button(100,20,self,"btn1"))
        
        func onButtonClick(event:Event){
            if(event.type == ButtonEvent.upInside){
                Swift.print("click")
                redBox
                let style = StyleManager.getStyle("#redBox")
                var styleProperty = style?.getStyleProperty("fill")
                Swift.print("styleProperty?.value: " + "\(styleProperty?.value)")
                styleProperty!.value = ("0x"+NSColor.magentaColor().hexString).uint
                Swift.print("styleProperty?.value: " + "\(StyleManager.getStyle("#redBox")?.getStyleProperty("fill")?.value)")
                ElementModifier.refresh(self)
            }
        }
        btn.event = onButtonClick
    }
    /**
     *
     */
    func liveEditTest2(){
        //create a testBtn
        StyleManager.addStyle("#testButton{fill:grey9;float:left;clear:left;corner-radius:4px;}")
        let testButton = addSubView(Button(100,20,self,"testButton"))
        
        //create a light theme button
        StyleManager.addStyle("#lightTheme{fill:grey9;float:left;clear:left;corner-radius:4px;}")
        let lightThemeButton = addSubView(Button(100,20,self,"lightTheme"))
        //create a dark theme button
        StyleManager.addStyle("#darkTheme{fill:grey3;float:left;clear:left;corner-radius:4px;}")
        let darkThemeButton = addSubView(Button(100,20,self,"darkTheme"))
        
        func onButtonClick(event:Event){//manually change the styles that belong to the button that will change.
            if(event.type == ButtonEvent.upInside){
                //let style = StyleManager.getStyle("#testButton")
                //var styleProperty = style?.getStyleProperty("fill")
                StyleManager.removeStyle("#testButton")
                if(event.origin === lightThemeButton){
                    StyleManager.addStylesByURL("~/Desktop/light.css")
                    //styleProperty!.value = StyleManager.getStyle("#lightTheme")!.getStyleProperty("fill")!.value
                }else if(event.origin === darkThemeButton){
                    StyleManager.addStylesByURL("~/Desktop/dark.css")
                    //styleProperty!.value = StyleManager.getStyle("#darkTheme")!.getStyleProperty("fill")!.value
                }
                Swift.print(StyleManager.getStyle("#testButton")!.getStyleProperty("fill")!.value)
            }
            ElementModifier.refreshSkin(self)//refresh self

            //testButton.setSkinState(SkinStates.none)
        }
        lightThemeButton.event = onButtonClick//onClick
        darkThemeButton.event = onButtonClick
    }
    /**
     * Tests 2 RadioBullet
     */
    func liveEditTest3(){
        //watch a css file for changes
        
        //on file change add the css file to the StyleManger.addStyleByURL(url) and call ElementModifier.refreshSkin(self)//refresh self
        
        //create a button
        //StyleManager.addStyle("#redBox{fill:red;float:left;clear:left;}")
        //StyleManager.addStylesByURL("~/Desktop/button.css",true)
        StyleManager.addStyle("Container#uiContainer{float:left;clear:left;padding:48px;}")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        let url:String = "~/Desktop/ElCapitan/basic/button/radiobullet.css"
        StyleManager.addStylesByURL(url,false)
        //let redBox = addSubView(Element(100,100,self,"redBox"))
        //redBox
        
        //let container = self.addSubView(Container(200,200,self,"uiContainer"))
        
        //let radioBullet:RadioBullet = container.addSubView(RadioBullet(NaN,NaN,false,container))
        //radioBullet
        
        //let card:Card = container.addSubView(Card(NaN, NaN, "RadioBullet: ", container, "radioBulletCard"))
        let section = container.addSubView(Section(NaN,NaN,container,"radioBulletSection"))
        let radioBullet1 = section.addSubView(RadioBullet(NaN,NaN,true,section))
        let radioBullet2 = section.addSubView(RadioBullet(NaN,NaN,false,section))
        let selectGroup = (SelectGroup([radioBullet1,radioBullet2],radioBullet1))
        selectGroup
        
        //style the button with red color from an external css file named ~/Desktop/button.css
        
        fileWatcher = FileWatcher([url.tildePath])
        
        fileWatcher!.event = { [weak self] event in
            Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                StyleManager.addStylesByURL(url,true)
                ElementModifier.refreshSkin(self!)
                ElementModifier.floatChildren(self!)
            }
        }
        
        fileWatcher!.start()
    }
}
