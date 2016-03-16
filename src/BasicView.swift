import Foundation

class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        
        /*
        createButton()
        createTextButton()
        createRadioBullet()
        createCheckBoxButton()
        createLeverSpinner()
        createTabBar()
        createIconButtons()
        createLeverStepper()
        createTextInput()
        createSingleLineTextArea()
        createText()
        createTextArea()
        createSearchBox()
        createVSlider()
        createHSlider()
        createCheckBox()
        createRadioButton()
        */
        createColorTag()
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
    func createIconButtons(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon button: ", container, "iconButtonCard"))
        let iconButton1 = card.addSubView(SelectButton(NaN,NaN,false,card,"first"))
        let iconButton2 = card.addSubView(SelectButton(NaN,NaN,false,card,"second"))
        let iconButton3 = card.addSubView(SelectButton(NaN,NaN,true,card,"third"))
        let iconButton4 = card.addSubView(SelectButton(NaN,NaN,false,card,"fourth"))
        let selectGroup = SelectGroup([iconButton1,iconButton2,iconButton3,iconButton4],iconButton3);
        selectGroup
    }
    func createLeverStepper(){
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverStepper: ", container, "leverStepperCard"))
        let stepper:LeverStepper = card.addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,card))
        stepper
    }
    func createTextInput(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "textInputCard"))
        let textInput:TextInput = card.addSubView(TextInput(NaN, NaN, "Description: ", "blue", card))
        textInput
    }
    func createSingleLineTextArea(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "singleLineTextAreaCard"))
        let textArea:TextArea = card.addSubView(TextArea(NaN, NaN, "This is a single line text area", card))
        textArea
    }
    func createText(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Text: ", container, "textCard"))
        let text:Text = card.addSubView(Text(100,24,"This is text: ",card))
        text
    }
    func createTextArea() {
        let card:Card = container.addSubView(Card(NaN, NaN, "Text area: ", container, "textAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/textarea.txt".tildePath)!
        let textArea:TextArea = card.addSubView(TextArea(180,68,text,card))
        textArea
    }
    func createSearchBox(){
        let searchBoxCard:Card = container.addSubView(Card(NaN, NaN, "Search box: ", container, "searchBoxCard"))
        let searchBox:TextArea = searchBoxCard.addSubView(TextArea(NaN, NaN, "Search", searchBoxCard))
        searchBox
    }
    func createVSlider(){
        let vSliderCard:Card = container.addSubView(Card(NaN, NaN, "Vertical slider: ", container, "vSliderCard"))
        let vSlider:VSlider = vSliderCard.addSubView(VSlider(6,60,30,0,vSliderCard))
        vSlider
    }
    func createHSlider(){
        let hSliderCard:Card = container.addSubView(Card(NaN, NaN, "Horizontal slider: ", container, "hSliderCard"))
        let hSlider:HSlider = hSliderCard.addSubView(HSlider(120,6,70,0,hSliderCard))
        hSlider
    }
    /**
     * Checkbox
     */
    func createCheckBox(){
        let checkBoxCard:Card = container.addSubView(Card(NaN, NaN, "CheckBox: ", container, "checkBoxCard"))
        let checkBoxContainer:Section = checkBoxCard.addSubView(Section(NaN,NaN,checkBoxCard,"checkBoxContainer"))
        let checkBox1:CheckBox = checkBoxContainer.addSubView(CheckBox(NaN,NaN,false,checkBoxContainer))
        let checkBox2:CheckBox = checkBoxContainer.addSubView(CheckBox(NaN,NaN,true,checkBoxContainer))
        let checkGroup:CheckGroup = CheckGroup([checkBox1,checkBox2], checkBox2)
        checkGroup
    }
    /**
     * RadioButton
     */
    func createRadioButton(){
        let radioButtonCard:Card = container.addSubView(Card(NaN, NaN, "Radio buttons: ", container, "radioButtonSection"))
        let radioButtonContainer:Element = radioButtonCard.addSubView(Section(NaN,NaN,radioButtonCard,"radioButtonContainer"))// :TODO: rename to background
        let radioButton1:RadioButton = radioButtonContainer.addSubView(RadioButton(80,14,"Option 1",false,radioButtonContainer))
        let radioButton2:RadioButton = radioButtonContainer.addSubView(RadioButton(80,14,"Option 2",true,radioButtonContainer))
        let selectGroup:SelectGroup = SelectGroup([radioButton1,radioButton2],radioButton2)
        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)");
        }
        selectGroup.event = onSelectGroupChange
    }
    func createColorTag(){
        let colorTagCard:Card = container.addSubView(Card(NaN, NaN, "Color tags: ", self, "colorTagCard"))
        let colorTagContainer:Section = colorTagCard.addSubView(Section(NaN,NaN,colorTagCard,"colorTagContainer"))
        let colors:Array<String> = ["blue","red","orange","green","yellow","purple","purple"]
        for color in colors{
            colorTagContainer.addSubView(RadioBullet(NaN,NaN,false,colorTagContainer,color))
        }
        let selectables = SelectParser.selectables(colorTagContainer)
        selectables[0].setSelected(true)
        let selectGroup = SelectGroup(selectables,selectables[0])
        selectGroup
    }
    
    
    
    //slider textArea
    //list
    //slider list
    
    //comboBox
    
    
    
}