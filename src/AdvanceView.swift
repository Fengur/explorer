import Foundation

class AdvanceView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        /**/
        //createTreeList()
        //createSliderTreeList()
        createTable()
    }
    func createTreeList(){
        
        
        //continue here: add the elcapitan style to the TreeList
        
    }
    func createSliderTreeList(){
        //get sliderTreeList working
    }
    func createTable(){
        let card = container.addSubView(Card(NaN, NaN, "Table: ", container, "tableCard"))
        
        let url:String = "~/Desktop/ElCapitan/advance/table/table.css"
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
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/table.xml")
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        node
        
        let table:Table = card.addSubView(Table(190,120,node,card))
        
        TableModifier.selectRow(table,1);
        
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
    }
}