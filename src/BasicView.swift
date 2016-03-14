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
        
        /*
        createButton()
        createTextButton()
        createRadioBullet()
        createCheckBoxButton()
        createLeverSpinner()
        createTabBar()
        */
        createIconButtons()
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
        let card:Card = container.addSubView(Card(NaN, NaN, "Tab bar: ", container, "tabBarCard"))
        let btn1 = card.addSubView(SelectTextButton(NaN,NaN,"first",false,card,"first"))
        let btn2 = card.addSubView(SelectTextButton(NaN,NaN,"second",true,card,"second"))
        let btn3 = card.addSubView(SelectTextButton(NaN,NaN,"third",false,card,"third"))
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn2)//SelectParser.selectables(card)
        selectGroup
    }
    
    //Continue here: icon buttons
    
    
    /**
     * iconButtonSection
     */
    func createIconButtons(){
        var css:String = "SelectButton{"
        css += "line:grey7,none;"
        css += "line-offset-type:outside;"
        css += "line-alpha:1;"
        css += "line-thickness:1px;"
        css += "margin-top:0px,1px;"
        css += "margin-left:0px,1px;"
        css += "width:24px,24px;"
        css += "height:24px,24px;"
        css += "drop-shadow:drop-shadow(0px 0 #FF0000 0.0 0 0 0 0 true);"
        css += "}"
        
        css += "SelectButton#first{"
        css += "fill:linear-gradient(top,#FFFEFE,#E8E8E8),~/Desktop/svg/icons/view/icons.svg grey5;"
        css += "corner-radius:4px 0px 4px 0px;"
        css += "}"
        
        css += "SelectButton#first:selected{"
        css += "fill:linear-gradient(top,grey9,grey8),~/Desktop/svg/icons/view/icons.svg white;"
        css += "}"
        
        css += "SelectButton#second{"
        css += "fill:linear-gradient(top,#FFFEFE,#E8E8E8),~/Desktop/svg/icons/view/list.svg grey5;"
        css += "corner-radius:0px;"
        css += "line-offset-type-right:inside;"
        css += "line-offset-type-left:inside;"
        css += "margin-left:0px,0px;"/*bug fix, sort it out later*/
        css += "}"
        
        css += "SelectButton#second:over{"/*bug fix, sort it out later*/
        css += "line-offset-type-right:inside;"
        css += "line-offset-type-left:inside;"
        css += "}"
        
        css += "SelectButton#second:selected{"
        css += "fill:linear-gradient(top,grey9,grey8),~/Desktop/svg/icons/view/list.svg white;"
        css += "margin-left:0px,0px;"/*bug fix, sort it out later*/
        css += "}"
        
        css += "SelectButton#third{"
        css += "fill:linear-gradient(top,#FFFEFE,#E8E8E8),~/Desktop/svg/icons/view/columns.svg grey5;"
        css += "corner-radius:0px;"
        css += "line-offset-type-right:inside;"
        css += "}"
        
        css += "SelectButton#third:selected{"
        css += "fill:linear-gradient(top,grey9,grey8),~/Desktop/svg/icons/view/columns.svg white;"
        css += "}"
        
        css += "SelectButton#fourth{"
        css += "fill:linear-gradient(top,#FFFEFE,#E8E8E8),~/Desktop/svg/icons/view/coverflow.svg grey5;"
        css += "corner-radius:0px 4px 0px 4px;"
        css += "}"
        
        css += "SelectButton#fourth:selected{"
        css += "fill:linear-gradient(top,grey9,grey8),~/Desktop/svg/icons/view/coverflow.svg white;"
        css += "}"
        /**/
        css += "SelectButton:selected{"
        css += "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        
        
        /**/
        
        let styleCollection:IStyleCollection = CSSParser.styleCollection(css)
        
        //let styleProperty = styleCollection.getStyle("SelectButton")?.getStyleProperty("corner-radius")
        //Swift.print("styleProperty.value: " + String(styleProperty!.value))
        StyleManager.addStyle(styleCollection.styles)
        
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon button: ", container, "iconButtonCard"))
        
        
        /**/
        let iconButton1 = SelectButton(24,24,false,card,"first")

        
        iconButton1.setPosition(CGPoint(10,20))
        card.addSubview(iconButton1)
        
        let iconButton2 = SelectButton(24,24,false,card,"second")
        card.addSubView(iconButton2)
        iconButton2.setPosition(CGPoint(10+24+2,20))
        
        let iconButton3 = SelectButton(24,24,false,card,"third")
        card.addSubView(iconButton3)
        iconButton3.setPosition(CGPoint(10+24+2+24,20))
        
        let iconButton4 = SelectButton(24,24,false,card,"fourth")
        card.addSubView(iconButton4)
        iconButton4.setPosition(CGPoint(10+24+2+24+24+1,20))/**/
         /**/
        
        
        
        
        
        
        let selectGroup = SelectGroup([iconButton1,iconButton2,iconButton3,iconButton4/**/],iconButton2);
        selectGroup
    }

    
}