import Cocoa
@testable import Element
@testable import Utils

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    weak var window: NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        //print(ArrayParser.difference([1,2], [1]))
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        //win = TranslucencyWin()
        
        
        StyleManager.addStyle("Container Container Container Button{thickness:30px;}Container Container Container Container Button{thickness:20px;}Container Button{thickness:10px;}")
        let a = Container(100,100)
        let b = a.addSubView(Container(100,100,a))
        let c = b.addSubView(Container(100,100,b))
        //let btn = Button(100,20)
        let btn2 = c.addSubView(Button(100,20,c))
        let props = btn2.skin?.style?.getStyleProperties("thickness")
        Swift.print("thickness: " + "\(props?.first?.value)")
        
        
    }
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
