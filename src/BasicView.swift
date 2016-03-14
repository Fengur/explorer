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
        //createButton()
        //createTextButton()
        //createRadioBullet()
        createCheckBoxButton()
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
    
    //continue with checkboxButtons
    
    /**
    *
    */
    func createCheckBoxButton(){
        var css:String = ""
        /*generics*/
        css += "ButtonBase{"
        css +=     "fill:linear-gradient(top,#FFFEFE,#E8E8E8);"
        css += "}"
        css += "ButtonHighlight{"
        css +=     "fill:linear-gradient(top,#BCD5EE 1 0.0087,#BAD4EE 1 0.0371,#B4CEEB 1 0.0473,#A8C4E7 1 0.0546,#98B6E0 1 0.0605,#98B5E0 1 0.0607,#96B4DF 1 0.2707,#8EB0DD 1 0.3632,#81A9DA 1 0.4324,#6EA0D6 1 0.4855,#538ECB 1 0.5087,#8ABBE3 1 0.8283,#A8D6EF 1 1);"
        css += "}"
        css += "InsetShadow{"
        css +=      "drop-shadow:drop-shadow(0px 0 #000000 0.4 4 4 1 2 true);"
        css += "}"
        /*CheckBoxButton*/
        css += "CheckBoxButton{"
        css +=     "float:left;"
        css +=     "clear:none;"
        css +=     "width:72px;"
        css +=     "drop-shadow:none;"
        css +=     "height:14px;"
        css +=     "margin-top:5px;"
        css +=     "padding:0px;"
        css +=     "margin-top:0px;"
        css +=     "margin-left:12px;"
        css += "}"
        css += "CheckBoxButton Text{"
        css +=     "clear:none;"
        css +=     "width:100%;"
        css +=     "font:Lucida Grande;"
        css +=     "size:12px;"
        css +=     "color:grey6;"
        css +=     "autoSize:left;"
        //css +=     "margin-top:0px;"
        css +=     "margin-left:0px;"
        css +=     "height:22px;"
        css +=     "margin-top:-1px;"
        css += "}"
        /*CheckBox*/
        css += "CheckBox{"
        css +=     "fill:<ButtonBase>,~/Desktop/svg/icons/check2.svg grey;"/*use fill-alpha 0,1 instead here*/
        css +=     "fill-alpha:1,0;"
        css +=     "float:left;"
        css +=     "clear:left;"
        css +=     "corner-radius:2px;"//2px
        css +=     "width:13px;"
        css +=     "height:13px;"
        css +=     "padding:0px;"
        css +=     "line:#707070;"//was grey9
        css +=     "line-alpha:1;"
        css +=     "line-thickness:1px;"
        css +=     "line-offset-type:outside;"
        css += "}"
        css += "CheckBox:checked{"
        css +=     "fill:<ButtonHighlight>,~/Desktop/svg/icons/check2.svg black;"
        css +=     "fill-alpha:1,1;"
        css +=     "line:#7692A9;"
        css += "}"
        /**/
        css += "CheckBoxButton CheckBox{"
        css +=    "margin-right:2px;"
        css +=    "margin-left:0px,1px;"
        css +=    "margin-top:0px,1px;"
        css += "}"
        /*Section*/
        //css += "Section#checkBoxButtonContainer{float:left;clear:left;padding-top:20px;padding-left:20px;}"
        /*section*/
        css += "Section#checkBoxButtonContainer{"
        css +=      "corner-radius:4px;"
        css +=      "fill:#EFEFF4;"//bg color for win: #E8E8E8
        css +=      "float:left;"
        css +=      "clear:left;"
        css +=      "width:178px;"//<---temp solution, this should be minus the padding left, test and fix this in a separate test
        css +=      "height:24px;"//<---same goes with this one
        css +=      "padding-left:0px;"
        css +=      "padding-top:0px;"
        css +=      "drop-shadow:<InsetShadow>;"
        css +=      "margin-left:12px;"
        css +=      "margin-top:12px;"
        css += "}"
        StyleManager.addStyle(css)
        
        let section = container.addSubView(Section(200, 200, container, "checkBoxButtonContainer")) /*this instance represents the inset shadow bagground and also holds the buttons*/
        let checkBoxButton1 = section.addSubView(CheckBoxButton(120, 32,"Option 1",true,section))
        let checkBoxButton2 = section.addSubView(CheckBoxButton(120, 32,"Option 2",false,section))
        
        let checkGroup = CheckGroup([checkBoxButton1,checkBoxButton2],checkBoxButton1)/*Add the CheckBoxButtons to the checkGroup instance*/
        func onEvent(event:Event){/*this is the event handler*/
            if(event.type == CheckGroupEvent.change){
                Swift.print("CustomView.onCheck() checked" + "\((event as! CheckGroupEvent).checked)")
            }
        }
        checkGroup.event = onEvent/*adds the event handler to the event exit point in the checkGroup*/
    }

}
