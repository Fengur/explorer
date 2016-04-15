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
        let tableCard:Card = container.addSubView(Card(NaN, NaN, "Table: ", self, "tableCard"))
        tableCard
        let xml:NSXMLElement = FileParser.xml("~/Desktop/assets/xml/table.xml")
        //Swift.print("xml: " + "\(xml)")
        let node:Node = Node(xml)
        node
        //var table:Table = tableCard.addSubView(Table(NaN,NaN,database,tableCard))
        //TableModifier.selectRow(table,1);
    }
}

//create a new repo named Table on GitHub and a new xcode project. 