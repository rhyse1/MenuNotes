import Cocoa

class NotesViewController: NSViewController {
    
    class func loadFromNib() -> NotesViewController{
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateController(withIdentifier: "NotesViewController") as! NotesViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}
