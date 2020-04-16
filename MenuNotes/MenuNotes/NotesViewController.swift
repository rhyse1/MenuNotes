import Cocoa

class NotesViewController: NSViewController {
    @IBOutlet weak var quitButton: NSButton!
    
    class func loadFromNib() -> NotesViewController{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "NotesViewController") as! NotesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quitButton.action = #selector(self.quitApplication)
    }
    
    @objc func quitApplication()
    {
        NSApplication.shared.terminate(self)
    }
    
}
