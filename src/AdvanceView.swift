import Foundation

class AdvanceView:CustomView {
    var container:Container!
    override func resolveSkin() {
        super.resolveSkin()
        container = addSubView(Container(1000,800,self,"main"))
        /**/
        //createTreeList()
        //createSliderTreeList()
        createTable()
    }
    func createTreeList(){
        
    }
    func createSliderTreeList(){
        
    }
    func createTable(){
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/table.xml")
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        var table:Table = tableSection.addChild(new Table(NaN,NaN,database,tableSection)) as Table;
        TableModifier.selectRow(table,1);
    }
}
