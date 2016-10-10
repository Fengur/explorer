import Foundation

class AdvanceView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        
        createTreeList()
        createSliderTreeList()
        createTable()
        /**/
    }
    func createTreeList(){
        let card = container.addSubView(Card(NaN, NaN, "TreeList: ", container, "treeListCard"))
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
        var treeList = card.addSubView(TreeList(140, 192, 24, Node(xml), card))
        
        Swift.print("selected: " + "\(TreeListParser.selected(treeList))")
        Swift.print("selectedIndex: " + "\(TreeListParser.selectedIndex(treeList))")//Output:  [2,2,0]
        Swift.print("selected Title: " + "\(XMLParser.attributesAt(treeList.node.xml, TreeListParser.selectedIndex(treeList))!["title"])")//Output: Oregano
        TreeListModifier.unSelectAll(treeList)
        
        TreeListModifier.selectAt(treeList, [2])
        TreeListModifier.collapseAt(treeList, [])//closes the treeList
        TreeListModifier.explodeAt(treeList,[])//opens the treeList
        
        treeList.node.removeAt([1])
        treeList.node.addAt([1],  NSXMLElement("<item title=\"Fish\"/>"))/*new*/
        
        //Swift.print("\(treeList.node.xml)")
        
        
        func onTreeListEvent(event: Event) {//add local event handler
            if(event.type == SelectEvent.select && event.immediate === treeList){
                //Swift.print("onTreeListSelect()")
                let selectedIndex:Array = TreeListParser.selectedIndex(treeList)
                Swift.print("selectedIndex: " + "\(selectedIndex)")
                //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
                let selectedXML:NSXMLElement = XMLParser.childAt(treeList.node.xml, selectedIndex)!
                //print("selectedXML: " + selectedXML);
                Swift.print("selectedXML.toXMLString():")
                Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
            }
        }
        treeList.event = onTreeListEvent//add local event listener
        
        
        //TODO: try the move up and move down methods
    }
    func createSliderTreeList(){
        let card = container.addSubView(Card(NaN, NaN, "SliderTreeList: ", container, "sliderTreeListCard"))
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)

        let scrollTreeList = card.addSubView(SliderTreeList(140, 192, 24, Node(xml),card))
        scrollTreeList
        //_scrollTreeList.database.addAt([0], <item title="Fish"/>);
        //print("_scrollTreeList.treeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
    }
    func createTable(){
        let card = container.addSubView(Card(NaN, NaN, "Table: ", container, "tableCard"))
        
        let url:String = "~/Desktop/ElCapitan/advance/table/table.css"
        StyleManager.addStylesByURL(url,true)
        
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/table.xml".tildePath)
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        node
        
        let table:Table = card.addSubView(Table(190,120,node,card))
        
        TableModifier.selectRow(table,1);
        
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
    }
}