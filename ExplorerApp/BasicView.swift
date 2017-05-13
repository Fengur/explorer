import Cocoa
@testable import Element
@testable import Utils
/**
 * TODO: Try to add Element here: https://github.com/vsouza/awesome-ios#layout (Requires Carthage, .framework and instalation section in readme)
 * TODO: Add flexbox support for Element see this lib for insp: https://github.com/stylekit/FlexboxLayout
 */
class BasicView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        let startTime = NSDate()
        createComponents()
        Swift.print("create content time: " + "\(abs(startTime.timeIntervalSinceNow))")
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
         createColorTag()/**/
        
        //createVNodeSlider()//not apart of basic anymore
        //createHNodeSlider()//not apart of basic anymore
    }
    /**
     * Button
     */
    func createButton(){
        Swift.print("createButton()")
        let card:Card = container.addSubView(Card(NaN, NaN, "Buttons: ", container, "buttonCard"))
        let button = card.addSubView(Button(96,24,card))
        func onbuttonDown(event:Event){
            Swift.print("event: " + "\(event)")
            if(event.type == ButtonEvent.upInside){
                Swift.print("ButtonEvent.upInside")
   
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
        _ = button
        
        //StyleParser.describe(StyleResolver.style(button))
    }
    /**
     * Volume slider
     */
    func createVolumeSlider(){
        let card:Card = container.addSubView(Card(NaN, NaN, "VolumeSlider: ", container, "volumeSliderCard"))
        let volumeSlider = card.addSubView(VolumeSlider(120,20,20,0,card))
        volumeSlider.setProgressValue(0.5)
        func onVolumeSliderChange(event: Event) {
            if(event.assert(SliderEvent.change, volumeSlider)){
                let volumSliderProgress = (event as! SliderEvent).progress
                Swift.print("volumSliderProgress: " + "\(volumSliderProgress)")
            }
        }
        volumeSlider.event = onVolumeSliderChange
    }
    /**
     * TextButton
     */
    func createTextButton(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextButton: ", container, "textButtonCard"))
        _ = card.addSubView(TextButton(NaN,NaN,"Button",card))
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
        _ = selectGroup
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
        func onEvent(event:Event){
            if(event.assert(StepperEvent.change, stepper)){
                let val = (event as! StepperEvent).value
                Swift.print("Stepper.value: " + "\(val)")
            }
        }
        stepper.event = onEvent
    }
    /**
     * TODO: create the LeverSpinner component with text
     */
    func createLeverSpinner(){
        let card:Card = container.addSubView(Card(NaN, NaN, "LeverSpinner: ", container, "leverSpinnerCard"))
        let leverSpinner:LeverSpinner = card.addSubView(LeverSpinner(NaN, NaN,"Value: ", 0, 1, Int.min.cgFloat, Int.max.cgFloat, 0, 100, 200, card))
        _ = leverSpinner
    }
    func createTabBar(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Tab bar: ", container, "tabBar"))
        let btn1 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 1",true,card,"first"))
        let btn2 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 2",false,card,"second"))
        let btn3 = card.addSubView(SelectTextButton(NaN,NaN,"Tab 3",false,card,"third"))
        let selectGroup = SelectGroup([btn1,btn2,btn3],btn1)//SelectParser.selectables(card)
        _ = selectGroup
    }
    func createIconButtons(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Icon button: ", container, "iconButtonsCard"))
        let iconButton1 = card.addSubView(SelectButton(NaN,NaN,false,card,"first"))
        let iconButton2 = card.addSubView(SelectButton(NaN,NaN,false,card,"second"))
        let iconButton3 = card.addSubView(SelectButton(NaN,NaN,true,card,"third"))
        let iconButton4 = card.addSubView(SelectButton(NaN,NaN,false,card,"fourth"))
        let selectGroup = SelectGroup([iconButton1,iconButton2,iconButton3,iconButton4],iconButton3);
        _ = selectGroup
    }
    func createTextInput(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "textInputCard"))
        let textInput:TextInput = card.addSubView(TextInput(NaN, NaN, "Description: ", "blue", card))
        _ = textInput
    }
    func createSingleLineTextArea(){
        let card:Card = container.addSubView(Card(NaN, NaN, "TextInput: ", container, "singleLineTextAreaCard"))
        let textArea:TextArea = card.addSubView(TextArea(NaN, NaN, "This is a single line text area", card))
        _ = textArea
    }
    /**
     * This creates a textField
     */
    func createText(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Text: ", container, "textCard"))
        let text:Text = card.addSubView(Text(100,24,"This is text: ",card))
        _ = text
    }
    func createTextArea(){
        let card:Card = container.addSubView(Card(NaN, NaN, "Text area: ", container, "textAreaCard"))
        let text:String = FileParser.content("~/Desktop/assets/txt/textarea.txt".tildePath)!
        let textArea:TextArea = card.addSubView(TextArea(180,74,text,card))
        _ = textArea
    }
    func createSearchBox(){
        let searchBoxCard:Card = container.addSubView(Card(NaN, NaN, "Search box: ", container, "searchBoxCard"))
        let searchBox:TextArea = searchBoxCard.addSubView(TextArea(NaN, NaN, "Search", searchBoxCard))
        _ = searchBox
    }
    /**
     * NOTE: see VolumSlider for eventListener
     */
    func createVSlider(){
        let vSliderCard:Card = container.addSubView(Card(NaN, NaN, "Vertical slider: ", container, "vSliderCard"))
        let vSlider:Slider = vSliderCard.addSubView(Slider(6,60,.ver,CGSize(30,30),0,vSliderCard))
        _ = vSlider
    }
    /**
     * NOTE: see VolumSlider for eventListener
     */
    func createHSlider(){
        let hSliderCard:Card = container.addSubView(Card(NaN, NaN, "Horizontal slider: ", container, "hSliderCard"))
        let hSlider:Slider = hSliderCard.addSubView(Slider(120,6,.hor,CGSize(70,70),0,hSliderCard))
        _ = hSlider
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
            _ = colorTagSection.addSubView(RadioBullet(NaN,NaN,false,colorTagSection,color))
        }
        let selectables = SelectParser.selectables(colorTagSection)
        //selectables[0].setSelected(true)
        let selectGroup = SelectGroup(selectables,selectables[0])
        _ = selectGroup
    }
    func createVNodeSlider(){
        let url:String = "~/Desktop/ElCapitan/basic/nodeslider/vnodeslider.css"
        StyleManager.addStylesByURL(url,true)

        let vNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Vertical node slider: ", container, "vNodeSliderCard"))
        let vNodeSlider:VNodeSlider = vNodeSliderCard.addSubView(VNodeSlider(20, 70, 20, 0, 1, vNodeSliderCard))
        _ = vNodeSlider
    }
    func createHNodeSlider(){
        let url:String = "~/Desktop/ElCapitan/basic/nodeslider/hnodeslider.css"
        StyleManager.addStylesByURL(url,true)
        
        let hNodeSliderCard:Card = container.addSubView(Card(NaN, NaN, "Horizontal node slider: ", container, "hNodeSliderCard"))
        let hNodeSlider:HNodeSlider = hNodeSliderCard.addSubView(HNodeSlider(120, 20, 20, 0, 1, hNodeSliderCard))
        _ = hNodeSlider
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
        let sliderList:SlideScrollList = sliderListCard.addSubView(SlideScrollList(140, 73, 24, dp, sliderListCard))
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
        _ = scrollTextArea
//		scrollTextArea.setSize(400, 250);
//		scrollTextAreaPanel.setPosition(new Point(LEFT_MARGIN+260,TOP_MARGIN));
    }
}
