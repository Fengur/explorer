import Foundation
@testable import Element
@testable import Utils

class AdvanceView:CustomView {
    var container:Container!
    var fileWatcher:FileWatcher?
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        
        treeList()
        createTable()
    }
    /**
     * Add SliderTreeList later
     */
    func treeList(){
        let url = "~/Desktop/assets/xml/treelist.xml"
        
        let dp: TreeDP = TreeDP(url.tildePath)
        let card = container.addSubView(Card(NaN, NaN, "SliderTreeList: ", container, "sliderTreeListCard"))
        let treeList = card.addSubView(TreeList3(140, 192, CGSize(24,24), dp, card))
        _ = treeList
        
        //treeList.select([2])/*Selects third item in root*/
        //treeList.open([2])/*Opens the first item in root*/
        //treeList.unSelectAll()
        //treeList.select([2,1])/*Selects nest item*/
        
        //Swift.print("Selected title: \(treeList.selected?.props?["title"])")
        //Swift.print("treeList.selected idx3d: " + "\(treeList.selectedIdx3d)")
        //treeList.unSelectAll()/*De-selects all selected items*/
        //treeList.collapseAll([])/*Collapses the treeList*/
        //treeList.explodeAll([])/*Explodes the treeList*/
        
        //treeList.remove([1])/*Removes an item at a idx3d*/
        //treeList.insert([1],Tree("item",[],nil,["title":"Fish"]))/*Insert item at*/
        
        let xml:XML = treeList.treeDP.tree.xml/*Converts the tree to an xml structure*/
        //Swift.print("xml.xmlString: " + "\(xml.xmlString)")/*Logs the tree as an xml structure*/
        _ = xml
        
        treeList.event = { event in/*add local event listener*/
            if(event.type == ListEvent.select && event.immediate === treeList){
                Swift.print("onTreeListSelect() event.origin: \(event.origin)")
                Swift.print("selectedIndex: " + "\(treeList.selectedIdx3d)")
                if let selectedIdx:[Int] = treeList.selectedIdx3d {
                    if let titleValue:String = treeList.treeDP.tree[selectedIdx]?.props?["title"] {
                        Swift.print("titleValue: " + "\(titleValue)")
                    }
                    /*if let selectedXML:XML = treeList.treeDP.tree[selectedIdx]?.xml{
                     Swift.print("selectedXML: \(selectedXML.xmlString)")//EXAMPLE output: <item title="Ginger"></item>
                     }*/
                }
            }
        }
    }
    func createTable(){
        /*let card = container.addSubView(Card(NaN, NaN, "Table: ", container, "tableCard"))
        
        let url:String = "~/Desktop/ElCapitan/advance/table/table.css"
        StyleManager.addStylesByURL(url,true)
        
        let xml:XML = FileParser.xml("~/Desktop/assets/xml/table.xml".tildePath)
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        _ = node
        
        let table:Table = card.addSubView(Table(190,120,node,card))
        
        TableModifier.selectRow(table,1);
        */
        // :TODO: TableParser.rowAt(0) should return an array with each the text from each row item
    }
}
/*
func createSliderTreeList(){
    let card = container.addSubView(Card(NaN, NaN, "SliderTreeList: ", container, "sliderTreeListCard"))
    let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
    
    let scrollTreeList = card.addSubView(SliderTreeList(140, 192, 24, Node(xml),card))
    _ = scrollTreeList
    //_scrollTreeList.database.addAt([0], <item title="Fish"/>);
    //print("_scrollTreeList.treeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
}
*/
/*
func createTreeList(){
    let card = container.addSubView(Card(NaN, NaN, "TreeList: ", container, "treeListCard"))
    
    let xml:XML = FileParser.xml("~/Desktop/assets/xml/treelist.xml".tildePath)
    var treeList = card.addSubView(TreeList(140, 192, 24, Node(xml), card))
    
    Swift.print("selected: " + "\(TreeListParser.selected(treeList))")
    Swift.print("selectedIndex: " + "\(TreeListParser.selectedIndex(treeList))")//Output:  [2,2,0]
    Swift.print("selected Title: " + "\(XMLParser.attributesAt(treeList.node.xml, TreeListParser.selectedIndex(treeList))!["title"])")//Output: Oregano
    TreeListModifier.unSelectAll(treeList)
    
    TreeListModifier.selectAt(treeList, [2])
    TreeListModifier.collapseAt(treeList, [])//closes the treeList
    TreeListModifier.explodeAt(treeList,[])//opens the treeList
    
    _ = treeList.node.removeAt([1])
    treeList.node.addAt([1], "<item title=\"Fish\"/>".xml)/*new*/
    
    //Swift.print("\(treeList.node.xml)")
    
    func onTreeListEvent(event:Event) {//adds local event handler
        if(event.type == SelectEvent.select && event.immediate === treeList){
            Swift.print("event.origin: " + "\(event.origin)")
            Swift.print("stackString: " + "💚\(ElementParser.stackString(event.origin as! IElement))💚")
            //Swift.print("onTreeListSelect()")
            let selectedIndex:Array = TreeListParser.selectedIndex(treeList)
            Swift.print("selectedIndex: " + "\(selectedIndex)")
            //print("_scrollTreeList.database.xml.toXMLString(): " + _scrollTreeList.database.xml.toXMLString());
            let selectedXML:XML = XMLParser.childAt(treeList.node.xml, selectedIndex)!
            //print("selectedXML: " + selectedXML);
            Swift.print("selectedXML.toXMLString():")
            Swift.print(selectedXML)//EXAMPLE output: <item title="Ginger"></item>
        }
    }
    treeList.event = onTreeListEvent//add local event listener
    
    //TODO: try the move up and move down methods
}
 
 */
