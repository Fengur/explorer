import Cocoa
@testable import Element
@testable import Utils

//Continue here: 🏀
    //add the extracted componets as standalone packages to Element explorer (later)
    //IconButton spacing 👈
    //Design GitSync v3 in illustrator 👈
    //Better window-dropshadow 👈   
    //More consts to enum
    //More code refactoring


@NSApplicationMain
class AppDelegate:NSObject,NSApplicationDelegate {
    weak var window:NSWindow!
    var win:NSWindow?/*<--The window must be a class variable, local variables doesn't work*/
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        //Insert code here to initialize your application
        //print(ArrayParser.difference([1,2], [1]))
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
        
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css",false)
        Swift.print("after css")
        win = RegularWin()//TranslucencyWin()
        
        //cssTest()
    }
    func applicationWillTerminate(_ aNotification:Notification) {
        // Insert code here to tear down your application
    }
}
