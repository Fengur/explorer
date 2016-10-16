import Cocoa
class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        let startTime = NSDate()
        createComponents()
        Swift.print("create content time: " + "\(abs(startTime.timeIntervalSinceNow))")
        
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
        for var i = 0; i < 144; ++i{
            let id:String = i % 12 == 0 ? "clear" : ""//the 13th element drops down bellow
            container.addSubView(Button(24,24,container,id))
        }
    }
    /**
     * NOTE: loads in 1.17secs (could be improved with a better style retreval system, or cahching the styles, maybe to around 0.5secs)
     */
    func createComponents(){
        createButton()
        createTextButton()
        createRadioBullet()
        createCheckBox()
        createRadioButton()
        createCheckBoxButton()
        createLeverStepper()
        createLeverSpinner()
        createHSlider()
        createVSlider()
        createVolumeSlider()
        createIconButton()
        createTabBar()
        createList()
        createSliderList()
        createIconButtons()
        createComboBox()
        createTextArea()
        createSliderTextArea()
        createText()
        createSingleLineTextArea()
        createSearchBox()
        createTextInput()
        createColorTag()
        /**/
        //createVNodeSlider()
        //createHNodeSlider()

    }
    /**
     * Button
     */
    func createButton(){
        Swift.print("createButton()")
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
     *
     */
    func createIconButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon Button: ", container, "iconButtonCard"))
        let button = card.addSubView(Button(NaN,NaN,card,"question"))
        button
        
        //StyleParser.describe(StyleResolver.style(button))
    }
    /**
     * Volume slider
     */
    func createVolumeSlider(){
        let card:Card = container.addSubView(Card(NaN, NaN, "VolumeSlider: ", container, "volumeSliderCard"))
        let volumeSlider = card.addSubView(VolumeSlider(120,20,20,0,card))
        volumeSlider.setProgressValue(0.5)
    }
    /**
     * TextButton
     */
    func createTextButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextButton: ", container, "textButtonCard"))
        card.addSubView(TextButton(NaN,NaN,"Button",card))
    }
    /**
     * RadioBullet
     */
    func createRadioBullet(){
        let card:Card = container.addSubView(Card(NaN, NaN, "RadioBullet: ", container, "radioBulletCard"))
        let section = card.addSubView(Section(NaN,NaN,card,"radioBulletSection"))
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
        let section = card.addSubView(Section(NaN, NaN, card, "checkBoxButtonSection")) /*this instance represents the inset shadow bagground and also holds the buttons*/
        let checkBoxButton1 = section.addSubView(CheckBoxButton(NaN, NaN,"Option 1",true,section))
        let checkBoxButton2 = section.addSubView(CheckBoxButton(NaN, NaN,"Option 2",false,section))
        let checkGroup = CheckGroup([checkBoxButton1,checkBoxButton2],checkBoxButton1)/*Add the CheckBoxButtons to the checkGroup instance*/
        func onEvent(event:Event){/*this is the event handler*/
            if(event.type == CheckGroupEvent.change){Swift.print("CustomView.onCheck() checked" + "\((event as! CheckGroupEvent).checked)")}
        }
        checkGroup.event = onEvent/*adds the event handler to the event exit point in the checkGroup*/
    }
    func createLeverStepper(){
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverStepper: ", container, "leverStepperCard"))
        let stepper:LeverStepper = card.addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,card))
        stepper
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
        let btn1 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 1",true,card,"first"))
        let btn2 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 2",false,card,"second"))
        let btn3 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 3",false,card,"third"))
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn1)//SelectParser.selectables(card)
        selectGroup
    }
    func createIconButtons(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon button: ", container, "iconButtonsCard"))
        let iconButton1 = card.addSubView(SelectButton(NaN,NaN,false,card,"first"))
        let iconButton2 = card.addSubView(SelectButton(NaN,NaN,false,card,"second"))
        let iconButton3 = card.addSubView(SelectButton(NaN,NaN,true,card,"third"))
        let iconButton4 = card.addSubView(SelectButton(NaN,NaN,false,card,"fourth"))
        let selectGroup = SelectGroup([iconButton1,iconButton2,iconButton3,iconButton4],iconButton3);
        selectGroup
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
    /**
     * This creates a textField
     */
    func createText(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Text: ", container, "textCard"))
        let text:Text = card.addSubView(Text(100,24,"This is text: ",card))
        text
    }
    func createTextArea(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Text area: ", container, "textAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/textarea.txt".tildePath)!
        let textArea:TextArea = card.addSubView(TextArea(180,74,text,card))
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
        let checkBoxContainer = checkBoxCard.addSubView(Section(NaN,NaN,checkBoxCard,"checkBoxSection"))
        let checkBox1 = checkBoxContainer.addSubView(CheckBox(NaN,NaN,false,checkBoxContainer))
        let checkBox2:CheckBox = checkBoxContainer.addSubView(CheckBox(NaN,NaN,true,checkBoxContainer))
        _ = CheckGroup([checkBox1,checkBox2], checkBox2)
    }
    /**
     * RadioButton
     */
    func createRadioButton(){
        let radioButtonCard:Card = container.addSubView(Card(NaN, NaN, "Radio buttons: ", container, "radioButtonCard"))
        let section:Section = radioButtonCard.addSubView(Section(NaN,NaN,radioButtonCard,"radioButtonSection"))// :TODO: rename to background
        let radioButton1:RadioButton = section.addSubView(RadioButton(80,14,"Option 1",false,section))
        let radioButton2:RadioButton = section.addSubView(RadioButton(80,14,"Option 2",true,section))
        let selectGroup:SelectGroup = SelectGroup([radioButton1,radioButton2],radioButton2)
        func onSelectGroupChange(event:Event){
            Swift.print("event.selectable: " + "\(event)")
        }
        selectGroup.event = onSelectGroupChange
    }
    func createColorTag(){
        let colorTagCard:Card = container.addSubView(Card(NaN, NaN, "Color tags: ", container, "colorTagCard"))
        let colorTagSection:Section = colorTagCard.addSubView(Section(NaN,NaN,colorTagCard,"colorTagSection"))
        let colors:Array<String> = ["red","orange","yellow","green","blue","purple","grey"]
        for color in colors{
            colorTagSection.addSubView(RadioBullet(NaN,NaN,false,colorTagSection,color))
        }
        let selectables = SelectParser.selectables(colorTagSection)
        //selectables[0].setSelected(true)
        let selectGroup = SelectGroup(selectables,selectables[0])
        selectGroup
    }
    func createVNodeSlider(){
        let url:String = "~/Desktop/ElCapitan/basic/nodeslider/vnodeslider.css"
        StyleManager.addStylesByURL(url,true)

        let vNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Vertical node slider: ", container, "vNodeSliderCard"))
        let vNodeSlider:VNodeSlider = vNodeSliderCard.addSubView(VNodeSlider(20, 70, 20, 0, 1, vNodeSliderCard))
        vNodeSlider
    }
    func createHNodeSlider(){
        let url:String = "~/Desktop/ElCapitan/basic/nodeslider/hnodeslider.css"
        StyleManager.addStylesByURL(url,true)
        
        let hNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Horizontal node slider: ", container, "hNodeSliderCard"))
        let hNodeSlider:HNodeSlider = hNodeSliderCard.addSubView(HNodeSlider(120, 20, 20, 0, 1, hNodeSliderCard))
        hNodeSlider
    }
    func createList(){
        let listCard:Card = container.addSubView(Card(NaN, NaN, "List: ", container, "listCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let list:List = listCard.addSubView(List(140, 73, NaN, dp,listCard))
        list.selectAt(1)
    }
    func createSliderList(){
        let sliderListCard:Card = container.addSubView(Card(NaN, NaN, "Slider list: ", container, "sliderListCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml".tildePath)//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        let sliderList:SliderList = sliderListCard.addSubView(SliderList(140, 73, 24, dp, sliderListCard))
        ListModifier.select(sliderList, "white")
        //scrollList.setMaxShowingItems(6);
        //print("scrollList.list.getSelected(): " + scrollList.list.getSelected());
        //var index:int = scrollList.list.getSelectedIndex();
        //print("selected Title: "+scrollList.list.dataProvider.getItemAt(index).title);
    }
    /**
     * NOTE: you can also create an XML as a string and call the "".xml call (instead of loading xml from a file)
     */
    func createComboBox(){
        let card = container.addSubView(Card(NaN, NaN, "ComboBox: ", container, "comboBoxCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/combobox.xml".tildePath)
        let dp:DataProvider = DataProvider(xml)
        let combobox = card.addSubView(ComboBox(170,96.0+8,24,dp,false,0,card))//+8: top/bottom margin in the comboboxwin
        
        func comboBoxEvent(event:Event){
            if(event.type == ComboBoxEvent.listSelect && event.origin === combobox){
                let selectedTitle:String = (event as! ComboBoxEvent).selectedTitle
                Swift.print("selectedTitle: " + "\(selectedTitle)")
                let selectedProperty:String = (event as! ComboBoxEvent).selectedProperty
                Swift.print("selectedProperty: " + "\(selectedProperty)")
            }
            Swift.print("combobox.selectedIndex: " + "\(combobox.selectedIndex)")
        }
        
        combobox.event = comboBoxEvent
		//print("combobox: "+StyleResolver.stackString(combobox))
        //comboBox.list.setMaxShowingItems(3)//TODO: implement this somehow
    }
    func createSliderTextArea() {
        let sliderTextAreaCard:Card = container.addSubView(Card(NaN, NaN, "Slider text area: ", container, "sliderTextAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/scrolltextarea.txt".tildePath)!
        let scrollTextArea:SliderTextArea = sliderTextAreaCard.addSubView(SliderTextArea(180,72,text,24,sliderTextAreaCard))
        scrollTextArea
//		scrollTextArea.setSize(400, 250);
//		scrollTextAreaPanel.setPosition(new Point(LEFT_MARGIN+260,TOP_MARGIN));
    }
}