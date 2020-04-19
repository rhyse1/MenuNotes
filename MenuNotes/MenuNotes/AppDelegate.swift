import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    //let menu = NSMenu()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        popover.behavior = NSPopover.Behavior.transient; // Hide when focus is lost
        
        if let button = statusItem.button{
            button.image = NSImage(named: "image")
            button.action = #selector(toggleWeather(sender:))
        }
        
        popover.contentViewController = NotesViewController.loadFromNib()
        //menu.addItem(NSMenuItem(title: "Show Weather", action: #selector(showWeather(sender:)), keyEquivalent: "S"))
        //menu.addItem(NSMenuItem.separator())
        //menu.addItem(NSMenuItem(title: "Quit", action: #selector(Process.terminate), keyEquivalent: "q"))
        
        //statusItem.menu = menu;
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func toggleWeather(sender: NSStatusBarButton){
        if popover.isShown{
            popover.performClose(sender)
        }else{
            if let button = statusItem.button{
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }

}

