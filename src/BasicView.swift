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
        */
        createLeverSpinner()
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
        var css:String = ""
        /*generics*/
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        /*leverSpinner css*/
        css += "Spinner{"
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "width:120px;"
        css +=      "height:24px;"
        css +=      "padding:0px;"
        css += "}"
        /*text css*/
        css += "Spinner TextInput{"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "width:90px;"
        css +=     "height:28px;"
        css +=     "margin-right:6px;"
        //css +=     "margin-top:4px;"
        css += "}"
        css += "Spinner TextInput Text{"
        css +=     "width:40px;"
        css +=     "height:28px;"
        css +=     "font:Lucida Grande;"
        //css +=     "selectable:false;"
        //css +=     "type:dynamic;"
        css +=     "wordWrap:true;"
        css +=     "size:12px;"
        css +=     "color:gray;"
        css +=     "align:left;"
        css +=     "backgroundColor:orange;"
        css +=     "background:false;"
        css +=     "margin-top:2px;"
        css +=     "float:left;"
        css +=     "clear:none;"
        css += "}"
        css += "Spinner TextInput TextArea{"
        css +=     "width:50px;"
        css +=     "height:20px;"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "fill:white;"
        css +=     "fill-alpha:1;"
        css +=     "line:grey9;"
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css +=     "drop-shadow:<InsetShadow>;"
        css += "}"
        css += "Spinner TextInput TextArea Text{"
        css +=     "width:100%;"
        css +=     "align:right;"
        css +=     "selectable:true;"
        css +=     "type:input;"
        //css +=     "mouseEnabled:true;"
        css += "}"
        
        /*stepper css*/
        
        css += "Stepper{"
        css +=    "padding-left:6px;"//<---temp fix
        css +=    "float:left;"
        css +=    "clear:none;"
        css += "}"
        css += "Stepper Button{"
        css +=    "padding-left:0px;"//<---temp fix
        css +=    "float:left;"
        css +=    "width:10px,10px;"
        css +=    "height:10px,10px;"
        css +=    "margin-left:0px,1px;"
        css +=    "fill-alpha:1;"
        css +=    "line:grey7;"
        css +=    "line-offset-type:outside;"
        css +=    "line-alpha:1;"
        css +=    "line-thickness:1px;"
        //css +=    "drop-shadow:<SubtleShadow>,none;"
        css += "}"
        css += "Stepper Button#plus{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_up_closed.svg grey8;"//assets/svg/icons/arrow_up_closed.svg
        css +=     "corner-radius:4px 4px 0px 0px;"
        css +=     "margin-top:0px,1px;"
        css += "}"
        css += "Stepper Button#minus{"
        css +=     "clear:left;"
        css +=     "height:10px,10px;"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/arrow_down_closed.svg grey8;"
        css +=     "line-offset-type-top:inside;"
        //css +=     "margin-top:0px;"
        css +=     "corner-radius:0px 0px 4px 4px;"
        css += "}"
        
        css += "Section#container{fill:green;fill-alpha:0;float:left;clear:left;padding-top:20px;padding-left:8px;}"
        StyleManager.addStyle(css)
        
        let section = container.addSubView(Section(200,200,container,"container"))
        
        
        let leverSpinner:LeverSpinner = section.addSubView(LeverSpinner(140, 40,"Value: ", 0, 1, CGFloat(Int.min), CGFloat(Int.max), 0, 100, 200, section))
        leverSpinner
        
        
    }
}