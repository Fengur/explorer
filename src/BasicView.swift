import Foundation

class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        super.resolveSkin()
        var css:String = ""
        css += ""
        //StyleManager.addStyle(css)
        Swift.print("hello world")
        container = addSubView(Container(1000,800,self,"main"))
        
        /*createButton()
        createTextButton()
        createRadioBullet()
        createCheckBoxButton()
        createLeverSpinner()*/
        
        createTabBar()
    }
    /**
     * Button
     */
    func createButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Buttons: ", container, "buttonCard"))
        let button = card.addSubView(Button(96,24,card))
        func onbuttonDown(event:Event){
            if(event.type == ButtonEvent.upInside){
                //var startTime:int = getTimer();
                //StyleResolver.style(event.target as Button);
                //print("selectRow-duration: " + (getTimer() - startTime));
            }
        }
        button.event = onbuttonDown
    }
    /**
     * TextButton
     */
    func createTextButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextButton: ", container, "textButtonCard"))
        card.addSubView(TextButton("Button",NaN,NaN,card))
    }
    /**
     * RadioBullet
     */
    func createRadioBullet(){
        let card:Card = container.addSubView(Card(NaN, NaN, "RadioBullet: ", container, "radioBulletCard"))
        let section = card.addSubView(Section(NaN,NaN,card,"radioBulletContainer"))
        let radioBullet1 = section.addSubView(RadioBullet(NaN,NaN,true,section))
        let radioBullet2 = section.addSubView(RadioBullet(NaN,NaN,false,section))
        let selectGroup = (SelectGroup([radioBullet1,radioBullet2],radioBullet1))
        selectGroup
    }
    /**
     * CheckboxButtons
     */
    func createCheckBoxButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "CheckBoxButton: ", container, "checkBoxButtonCard"))
        let section = card.addSubView(Section(NaN, NaN, card, "checkBoxButtonContainer")) /*this instance represents the inset shadow bagground and also holds the buttons*/
        let checkBoxButton1 = section.addSubView(CheckBoxButton(NaN, NaN,"Option 1",true,section))
        let checkBoxButton2 = section.addSubView(CheckBoxButton(NaN, NaN,"Option 2",false,section))
        let checkGroup = CheckGroup([checkBoxButton1,checkBoxButton2],checkBoxButton1)/*Add the CheckBoxButtons to the checkGroup instance*/
        func onEvent(event:Event){/*this is the event handler*/
            if(event.type == CheckGroupEvent.change){Swift.print("CustomView.onCheck() checked" + "\((event as! CheckGroupEvent).checked)")}
        }
        checkGroup.event = onEvent/*adds the event handler to the event exit point in the checkGroup*/
    }
    /**
     * TODO: create the LeverSpinner component with text
     */
    func createLeverSpinner(){
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverSpinner: ", container, "leverSpinnerCard"))
        let leverSpinner:LeverSpinner = card.addSubView(LeverSpinner(NaN, NaN,"Value: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, card))
        leverSpinner
    }
    
    
    
    
    func createTabBar(){
        
        //TODO: maybe implement height with the Text element
        //TODO: make parenting work with element
        
        //let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        
        //let styleProperty = styleCollection.getStyle("SelectButton")?.getStyleProperty("corner-radius")
        //Swift.print("styleProperty.value: " + String(styleProperty!.value))
        //StyleManager.addStyle(styleCollection.styles)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Tab bar: ", container, "tabBarCard"))
        
        
        //Continue here: add # and use NaN
        
        let btn1 = SelectTextButton(64,24,"first",false,card,"first")
        btn1.setPosition(CGPoint(10,20))
        card.addSubview(btn1)
        
        let btn2 = SelectTextButton(64,24,"second",true,card,"second")
        btn2.setPosition(CGPoint(74,20))
        card.addSubview(btn2)
        
        let btn3 = SelectTextButton(64,24,"third",false,card,"third")
        btn3.setPosition(CGPoint(138,20))
        card.addSubview(btn3)
        
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn2);
        selectGroup
    }
    
}