import Foundation

class BasicView:CustomView {
    var container:Container!
    
    var fileWatcher:FileWatcher?
    
    
    override func resolveSkin() {
        
        
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        //createVNodeSlider()
        //createHNodeSlider()
        //createRadioBullet()
        //createCheckBox()
        //createLeverStepper()
        //createIconButtons()
        //createButton()
        //createTextButton()
        //createTabBar()
        //createSearchBox()
        //createComboBox()
        //createColorTag()
        //createText()
        //createTextInput()
        //createTextArea()
        //createSingleLineTextArea()
        //createCheckBoxButton()
        //createLeverSpinner()
        //createRadioButton()
        //createVSlider()
        //createHSlider()
        //createList()
        //createSliderList()
        createSliderTextArea()
        
        
        
        /*
        */
    }
    /**
     * Button
     */
    func createButton(){
        let url:String = "~/Desktop/ElCapitan/basic/button/button.css"
        StyleManager.addStylesByURL(url,false)
        
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
        
        let url:String = "~/Desktop/ElCapitan/basic/button/textbutton.css"
        StyleManager.addStylesByURL(url,false)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "TextButton: ", container, "textButtonCard"))
        card.addSubView(TextButton("Button",NaN,NaN,card))
    }
    /**
     * RadioBullet
     */
    func createRadioBullet(){
        
        let url:String = "~/Desktop/ElCapitan/basic/button/radiobullet.css"
        StyleManager.addStylesByURL(url,true)
        
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
        let url:String = "~/Desktop/ElCapitan/basic/button/checkboxbutton.css"
        StyleManager.addStylesByURL(url,false)
        
        
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
    /**
     * TODO: create the LeverSpinner component with text
     */
    func createLeverSpinner(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/stepper/leverstepper.css")
        let url:String = "~/Desktop/ElCapitan/basic/spinner/leverspinner.css"
        StyleManager.addStylesByURL(url,true)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverSpinner: ", container, "leverSpinnerCard"))
        let leverSpinner:LeverSpinner = card.addSubView(LeverSpinner(NaN, NaN,"Value: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, card))
        leverSpinner
    }
    func createTabBar(){
        let url:String = "~/Desktop/ElCapitan/basic/button/tabbar.css"
        StyleManager.addStylesByURL(url,false)
        
        
        
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Tab bar: ", container, "tabBarCard"))
        let btn1 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 1",false,card,"first"))
        let btn2 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 2",true,card,"second"))
        let btn3 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 3",false,card,"third"))
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn2)//SelectParser.selectables(card)
        selectGroup
    }
    func createIconButtons(){
        
        let url:String = "~/Desktop/ElCapitan/basic/button/iconbutton.css"
        StyleManager.addStylesByURL(url,false)
       
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon button: ", container, "iconButtonCard"))
        let iconButton1 = card.addSubView(SelectButton(NaN,NaN,false,card,"first"))
        let iconButton2 = card.addSubView(SelectButton(NaN,NaN,false,card,"second"))
        let iconButton3 = card.addSubView(SelectButton(NaN,NaN,true,card,"third"))
        let iconButton4 = card.addSubView(SelectButton(NaN,NaN,false,card,"fourth"))
        let selectGroup = SelectGroup([iconButton1,iconButton2,iconButton3,iconButton4],iconButton3);
        selectGroup/**/
        /**/
    }
    func createLeverStepper(){
        let url:String = "~/Desktop/ElCapitan/basic/stepper/leverstepper.css"
        StyleManager.addStylesByURL(url,false)
        
        
        
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverStepper: ", container, "leverStepperCard"))
        card
        let stepper:LeverStepper = card.addSubView(LeverStepper(NaN,NaN,0,1,Int.min.cgFloat,Int.max.cgFloat,0,100,200,card))
        stepper
    }
    func createTextInput(){
        let url:String = "~/Desktop/ElCapitan/basic/text/textinput.css"
        StyleManager.addStylesByURL(url,false)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "textInputCard"))
        let textInput:TextInput = card.addSubView(TextInput(NaN, NaN, "Description: ", "blue", card))
        textInput
    }
    func createSingleLineTextArea(){
        let url:String = "~/Desktop/ElCapitan/basic/text/singlelinetextarea.css"
        StyleManager.addStylesByURL(url,true)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "singleLineTextAreaCard"))
        let textArea:TextArea = card.addSubView(TextArea(NaN, NaN, "This is a single line text area", card))
        textArea
    }
    func createText(){
        let url:String = "~/Desktop/ElCapitan/basic/text/text.css"
        StyleManager.addStylesByURL(url,false)
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Text: ", container, "textCard"))
        let text:Text = card.addSubView(Text(100,24,"This is text: ",card))
        text
    }
    func createTextArea() {
        let url:String = "~/Desktop/ElCapitan/basic/text/textarea.css"
        StyleManager.addStylesByURL(url,true)
    
        
        let card:Card = container.addSubView(Card(NaN, NaN, "Text area: ", container, "textAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/textarea.txt".tildePath)!
        let textArea:TextArea = card.addSubView(TextArea(180,74,text,card))
        textArea
    }
    func createSearchBox(){
        let url:String = "~/Desktop/ElCapitan/basic/text/searchbox.css"
        StyleManager.addStylesByURL(url,true)
        
        /**/
        let searchBoxCard:Card = container.addSubView(Card(NaN, NaN, "Search box: ", container, "searchBoxCard"))
        let searchBox:TextArea = searchBoxCard.addSubView(TextArea(NaN, NaN, "Search", searchBoxCard))
        searchBox
    }
    func createVSlider(){
        
        let url:String = "~/Desktop/ElCapitan/basic/slider/vslider.css"
        StyleManager.addStylesByURL(url,true)
        
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
        checkBoxCard
        let checkBoxContainer = checkBoxCard.addSubView(Section(NaN,NaN,checkBoxCard,"checkBoxSection"))
        checkBoxContainer
        let checkBox1 = checkBoxContainer.addSubView(CheckBox(NaN,NaN,false,checkBoxContainer))
        checkBox1
        let checkBox2:CheckBox = checkBoxContainer.addSubView(CheckBox(NaN,NaN,true,checkBoxContainer))
        let checkGroup:CheckGroup = CheckGroup([checkBox1,checkBox2], checkBox2)
        checkGroup
        /**/
        
        
        
        
    }
    /**
     * RadioButton
     */
    func createRadioButton(){
        
        let url:String = "~/Desktop/ElCapitan/basic/button/radiobutton.css"
        StyleManager.addStylesByURL(url,true)
        
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
        let url:String = "~/Desktop/ElCapitan/basic/button/colortag.css"
        StyleManager.addStylesByURL(url,true)
        
        let colorTagCard:Card = container.addSubView(Card(NaN, NaN, "Color tags: ", container, "colorTagCard"))
        let colorTagSection:Section = colorTagCard.addSubView(Section(NaN,NaN,colorTagCard,"colorTagSection"))
        colorTagSection
        let colors:Array<String> = ["blue","red","orange","green","yellow","purple","grey"]
        for color in colors{
            colorTagSection.addSubView(RadioBullet(NaN,NaN,false,colorTagSection,color))
        }
        let selectables = SelectParser.selectables(colorTagSection)
        //selectables[0].setSelected(true)
        let selectGroup = SelectGroup(selectables,selectables[0])
        selectGroup/**/
    }
    func createVNodeSlider(){
        let vNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Vertical node slider: ", container, "vNodeSliderCard"))
        let vNodeSlider:VNodeSlider = vNodeSliderCard.addSubView(VNodeSlider(20, 70, 20, 0, 1, vNodeSliderCard))
        vNodeSlider
    }
    func createHNodeSlider(){
        let hNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Horizontal node slider: ", container, "hNodeSliderCard"))
        let hNodeSlider:HNodeSlider = hNodeSliderCard.addSubView(HNodeSlider(120, 20, 20, 0, 1, hNodeSliderCard))
        hNodeSlider
    }
    func createList(){
        let url:String = "~/Desktop/ElCapitan/basic/list/list.css"
        StyleManager.addStylesByURL(url)
        
        let listCard:Card = container.addSubView(Card(NaN, NaN, "List: ", container, "listCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/list.xml")
        let dp:DataProvider = DataProvider(xml)
        let list:List = listCard.addSubView(List(140, 73, NaN, dp,listCard))
        ListModifier.selectAt(list, 1);
    }
    func createSliderList(){
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/slider/vslider.css")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/list/list.css")
        let url:String = "~/Desktop/ElCapitan/basic/list/sliderlist.css"
        StyleManager.addStylesByURL(url,true)
        
        let sliderListCard:Card = container.addSubView(Card(NaN, NaN, "Slider list: ", container, "sliderListCard"))
        let xml = FileParser.xml("~/Desktop/assets/xml/scrollist.xml")//TODO:  create a method tht takes url and makes dp
        let dp:DataProvider = DataProvider(xml)
        let sliderList:SliderList = sliderListCard.addSubView(SliderList(140, 73, 24, dp, sliderListCard))
        ListModifier.select(sliderList, "blue")
        //scrollList.setMaxShowingItems(6);
        //print("scrollList.list.getSelected(): " + scrollList.list.getSelected());
        //var index:int = scrollList.list.getSelectedIndex();
        //print("selected Title: "+scrollList.list.dataProvider.getItemAt(index).title);
    }
    //comboBox
    func createComboBox(){
        let url:String = "~/Desktop/ElCapitan/basic/combobox/combobox.css"
        StyleManager.addStylesByURL(url,false)
        
        let comboBoxCard:Card = container.addSubView(Card(NaN, NaN, "ComboBox: ", container, "comboBoxSection"))
        let xml = FileParser.xml("~/Desktop/assets/xml/combobox.xml")
        let dp:DataProvider = DataProvider(xml)
        let combobox = comboBoxCard.addSubView(ComboBox(140,96,24,dp,false,0,comboBoxCard))
        combobox
//		print("combobox: "+StyleResolver.stackString(combobox))
//		comboBox.setOpen(false)
//		comboBox.list.setSelected("white")
//		comboBox.list.setMaxShowingItems(3)
//		comboBox.list.getSelectedItem()["property"];/*returns the property*/
//		comboBox.scrollList.scrollBar.visible = false
//		print("selected index: " + comboBox.scrollList.list.getSelectedIndex())
//		print("selected Title: "+comboBox.scrollList.list.getSelectedTitle())
    }
    func createSliderTextArea() {
        
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/slider/vslider.css")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/basic/text/textarea.css")
        let url:String = "~/Desktop/ElCapitan/basic/text/slidertextarea.css"
        StyleManager.addStylesByURL(url,true)
        
        fileWatcher = FileWatcher([url.tildePath])
        fileWatcher!.event = { event in
            //Swift.print(self)
            Swift.print(event.description)
            if(event.fileChange && event.path == url.tildePath) {
                StyleManager.addStylesByURL(url,true)
                ElementModifier.refreshSkin(self)
                ElementModifier.floatChildren(self)
            }
        }
        fileWatcher!.start()
        
        let sliderTextAreaCard:Card = container.addSubView(Card(NaN, NaN, "Slider text area: ", container, "sliderTextAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/scrolltextarea.txt".tildePath)!
        let scrollTextArea:SliderTextArea = sliderTextAreaCard.addSubView(SliderTextArea(180,72,text,24,sliderTextAreaCard))
        scrollTextArea
//		scrollTextArea.setSize(400, 250);
//		scrollTextAreaPanel.setPosition(new Point(LEFT_MARGIN+260,TOP_MARGIN));
    }
    
}