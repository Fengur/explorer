import Cocoa
/**
 * This is the main class for the application
 */
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    weak var window: NSWindow!/*<--This is here only so that the compiler wont throw an error*/
    var win:NSWindow?/*<--The window must be a class variable, local variables doesnt work*/
    func applicationDidFinishLaunching(aNotification:NSNotification) {
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/window.css")
        //StyleManager.addStylesByURL("~/Desktop/ElCapitan/card.css")
        StyleManager.addStylesByURL("~/Desktop/ElCapitan/explorer.css")
        let result = Utils.groupBy([Style(),Style(),Style()], f: { $0.selectors.count })
        //StyleManager.addStylesByURL("~/Desktop/css/explorer/explorer.css")
        win = TranslucencyWin()//Win(400,300/**//*1000,800*/)//()//
        NSApp.windows[0].close()/*<--Close the initial non-optional default window*/
    }
    func applicationWillTerminate(aNotification: NSNotification) {
        //print("Good-bye")
    }
}

private class Utils{
    /**
     * Creates a directory with lists of styles. if style.selector.count is 3, then its added to the key:3 and also every key that is bigger than 3
     * PARAM: f: the key to group by (its a method that gets each item in items)
     * PARAM: items: the items to be grouped
     * PARAM: o: is an item in items
     *
     */
    class func groupBy<T, H: Hashable>(items: [T], f: (T) -> H) -> [H: [T]] {
        return items.reduce([:], combine: { (var ac: [H: [T]], o: T) -> [H: [T]] in
            let selectorCount:Int = f(o)/*h is the key, an item is passed to f to get h*/
            if var c = ac[selectorCount] {/*if something already exist at key: h then append to that value*/
                c.append(o)
                ac.updateValue(c, forKey: selectorCount)/*re-add that value*/
            }
            ac.keys.forEach{
                if(h > $0) {
                    ac.updateValue([o], forKey: selectorCount)/*add the item from items as an array*/
                }
            }
            return ac/*Return the grouped list*/
        })
    }
    
}